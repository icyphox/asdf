#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PWCMD "pw -s ircpass"

int main() {
    FILE *fp = popen(PWCMD, "r");
    char key[128];
    printf("running cmd!\n");
    if (fp == NULL)
        printf("failed to run command!");

    fgets(key, 128, fp);
    pclose(fp);
    char key0[128];
    printf("reading from env!\n");
    strcpy(key0, getenv("IRCPASS"));
    key[strcspn(key, "\n")] = 0;
    if(!strcmp(key, key0)) {
        printf("same");
    }
    else
        printf("nope");
}
