#include <stdio.h>
#include <stdlib.h>
#define NOTIFY 1

int main() {
    char cmd[256];
    if (NOTIFY) {
        snprintf(cmd, sizeof(cmd), "notify-send \"%s @ %s\" \"%s\"", "test", "#channel", "some message");
        system(cmd);
    }
}
