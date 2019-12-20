#include <stdlib.h>
#include <stdio.h>

void caf(char *in_buf) {
    for(char c = *in_buf++; c != '\x00'; c = *in_buf++) {
        if(c == 'A') {
            printf("blocked!\n");
            exit(-1);
        }
    }
}

void caftest() {
    char buf[256] = {0};
    printf("\nenter payload:\n");
    gets(buf);
    caf(buf);
    printf(buf);
}

int main(int argc, char* argv[]) {
    while(1) {
        caftest();
    }
}
