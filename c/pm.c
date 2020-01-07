#include <string.h>
#include <stdio.h>

int main() {
    char *m = "/q some message here";
    char *p = m;
    m = p + 1 + (p[2] == ' ');
    if (!(p = strchr(m, ' ')))
        printf("returning");
    *p++ = 0;
    printf("PRIVMSG %s :%s", m, p);

    return 0;
}
