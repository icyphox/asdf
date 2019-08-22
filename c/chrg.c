#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define FILE_PATH "syscall_test.txt"

int main(){
	//Varibale definations
	int fd;
	FILE *fp;
	char ch;

	fd = open(FILE_PATH, O_RDONLY);

	if (fd == -1){
		printf("[!]Error can't open file\n");
	} else {
		printf("[*]File opened successfully!\n");
		printf("[*]Contents of file are:\n");
		fp = fdopen(fd, "r");

		while((ch = fgetc(fp)) != EOF){
			printf("%c", ch);
		}

		close(fp);
	}

	close(fd);

	return 0;
}
