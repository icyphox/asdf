#include <string.h>
#include <stdio.h>
#include <malloc.h>

int main() {
    char *s = "/q some string here";
    int len = strlen(s);
    char *p = (char *) malloc(len * sizeof(char));
    strcpy(p, s);
    p += 3;

    char *uname = strtok(p, " ");
    printf("%s\n", uname);
    char *msg = strtok(NULL, "\0");
    printf("%s\n", msg);

}
