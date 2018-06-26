"""
Rules 1: We know that nobody sent you the invite code
You don't have to inform anyone about "hacking" the invite code

Dont spoil ! I'am using this script to speed up the process ! try first to solve it
By Ihebski
"""
import requests
import base64
import json
print "[+] Hackthebox invite Code"
print "[+] connect to server hackthebox.eu ..."
print "[+] Invite Code : ",base64.b64decode(requests.post("https://www.hackthebox.eu/api/invite/generate", json={"key": "value"}).json()["data"]["code"])
