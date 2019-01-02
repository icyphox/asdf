---
title: What are CTFs and Why You Should Care 
status: draft
tags: ['infosec', 'hacking', 'CTF']
---

You’re not a “security professional” if you don’t play CTFs. No, I’m not gatekeeping.

# A quick intro to CTFs

“Capture The Flag” (ah finally, the expansion) is a competetion between security professionals or people studying cyber security. They are challenges which help the player learn about the real world applications of IT security principles.

Still don’t get it? Okay, think of a corporate network infrastructure, complete with a web application, centralized authentication like Kerberos, designed with a few security flaws. Something that a lazy sysadmin might’ve made.

You now have a typical CTF challenge. The task is to break into the system(s), escalate privileges and grab the root flag, which is usually a text file that can only be read by the `root` user. 

How, you might ask. Well, that’s the challenge isn’t it? If you really are in infosec, you shouldn’t be asking this. But for those of you who aren’t in infosec or just getting started, read on.

# Why should I even bother?

Think competetive programming, but for security professionals. If developers are hired based on their competetive programming ability (which is a pretty bad metric, IMO), security pros are hired, or should be hired, based on their ability to solve CTF challenges.

More than your technical ability, it also showcases your ability to approach the challenge itself. Let’s consider the previous example. If running an `nmap` scan on the target IP shows you a publicly browsable Active Directory share, but instead you decide to bruteforce the login page on the webapp — you’re a retard who should go back to the JS dev cesspit.

# Well okay, but how do I solve these challenges?

That’s a tough question to answer. To start with, you’ll need to understand computers and computery things work intrinsically. Do a CS degree. As much of a meme it may be, let’s face it, you don’t know it all.

CTFs generally incorporate various facets of infosec into one single challenge. Which also means that you’ll need to know at least the basics of everything. 

Here are a few things part of the “everything”, that you *need* to know:

- **Web security fundamentals**: [OWASP Top 10](https://www.owasp.org/index.php/Top_10-2017_Top_10) is a great place to start.
- **Linux and its fundamentals**: I feel like this should be taught in school, instead of garbage like MS Word and Excel.
- **Networking and cryptography**: The different protocol stacks, modern cryptography techniques 
- **Low-level programming**: x86 Assembly, registers, stacks
- **Reverse engineering and binary exploitation**: Decompiling a binary, buffer overflows, heap overflows etc.
- **Basic forensics**: Filesystems, data recovery, scanning logs and network captures
- **Steganography principles**: detecting stego, file signatures, etc.

“Okay, I’ve done all of this. Can I start now?” Sure, you can, but it’s still a long way from here. You will find your first few CTFs completely overwhelming, without a clue on how to begin. 

For this, I suggest reading write-ups of challenges. Platforms like [Root Me](https://root-me.org) have VMs that you can spin up on demand to practice against. All these VMs have write-ups. Once you feel confident with your procedures and techniques, head to [HackTheBox](https://hackthebox.eu). Here comes the second shocker. None of the active boxes have write-ups. You’ll have to solve them with the help of hints from the forums.

During your journey, you’ll come across various tools, techniques, procedures, different kinds of environments and how to adapt to each one of them. You may even have to write your own tools to solve some challenges. It’s not going to be easy, but it’ll definitely be rewarding.

# Arguments against CTFs

**“bUt CtFs aRe jUsT sTeGo/cRyPtO rIdDeN TiMeSiNkS!”**

If it is, then it’s a bad CTF. Plain and simple. 

# Conclusion

Every box teaches you something new, and at least in my case, helped me overcome my inferiority complex when I solved one without any hints/help. There’s no hard and fast rule to approaching a CTF. Be creative, approach it from multiple perspectives. It can be very easy to fall into a rabbit hole when the actual solution is staring at you in the face.

Keep playing, build an intuition for it, and don’t forget to stay hydrated.

------------------------

I’m Anirudh but I go by “icyphox” on the Internet. 

## Links

- [GitHub](https://github.com/icyphox)
- [Website](https://icy.ph0x.me)
- [Twitter](https://twitter.com/icyphox)

Don’t hesitate to shoot me a mail at [icyph0x@pm.me](mailto:icyph0x@pm.me).

