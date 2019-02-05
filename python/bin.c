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
