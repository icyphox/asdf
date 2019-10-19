#include <stdio.h>

int main() {
    int n, i, a, b, f = 0, t = 0, w = 0;
    printf("n: ");
    scanf("%d", &n);
    for(i=0;i<n;i++) {
        printf("process %d\n", i+1);
        printf("arrival time: ");
        scanf("%d", &a);
        printf("burst time: ");
        scanf("%d", &b);
        f=b+f;
        t=f-a;
        w=t-b;
        printf("\nfinish time: %d\n", f);
        printf("turn around time: %d\n", t);
        printf("waiting time: %d\n\n\n", w);
    }
    return 0;
}
