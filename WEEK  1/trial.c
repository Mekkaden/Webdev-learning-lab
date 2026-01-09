#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>

int main( int argc  , char *argv[]){

    printf("We winning with this one");
    int rc = fork();
    if(rc < 0 ){
        fprintf(stderr , "CHild havent born\n");
        exit(1);
    }else if(rc == 0 ){
        printf("Hello im child    %d\n " ,  (int) getpid() );

    }else{
        printf("im a")
    }

}
