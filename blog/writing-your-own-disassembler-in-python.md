---
title: Reversing ELF and PE binaries with Python
status: draft
tags: ['python', 'reverse engineering', 'security']
---

Given a PE or an ELF file to reverse, we often use tools like radare2 or
IDA for debugging and disassembly. But rolling your own scripts for this
gives you a lot more control over the process, and perhaps, give you
deeper insight into what really goes on under the hood.

# Setup

As the title suggests, you’re going to need a Python 3 interpreter before
anything else. Once you’ve confirmed beyond reasonable doubt that you do,
infact, have a Python 3 interpreter installed on your system, run 

```
$ pip install capstone pyelftools pefile 
```

where *capstone* is the disassembly engine we’ll be scripting with, and
the other two are modules to parse ELF and PE files.

With that out of the way, let’s start with an example of a basic reversing
challenge.

```C 
/* chall.c */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
	char pw[9];
	pw[0] = 'a';
	for(int i = 1; i <= 8; i++){
		pw[i] = pw[i - 1] + 1;
	}
	pw[9] = '\0';
	char *in = malloc(10);
	printf("password: ");
	fgets(in, 10, stdin);
	if(strcmp(in, pw) == 0) {
		printf("haha yes!\n");
	}
	else {
		printf("nah dude\n");
	}
}
```

# Reversing

