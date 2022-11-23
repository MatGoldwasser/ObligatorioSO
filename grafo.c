#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>
#include <unistd.h>

int v = 0;
sem_t semA,semB, semC, semD, semE, semF; // semaforos

void* procA (void * x){ // A
   usleep((rand() % 500)  * 1000);
   printf("A");
   sem_post(&semB); // signal semB
   sem_post(&semC); // signal semC
   }

void* procB (void * x){ // B
    sem_wait(&semB); // wait
    usleep((rand() % 500)  * 1000);
    printf("B");
   }

void* procC (void * x){ // C
    sem_wait(&semC); // wait
    usleep((rand() % 500)  * 1000);
    printf("C");
    sem_post(&semD); // signal
    sem_post(&semE); // signal
   }

void* procD (void * x){ // D
    sem_wait(&semD); // wait
    usleep((rand() % 500)  * 1000);
    printf("D");
    sem_post(&semF); // signal
   }

void* procE (void * x){ // D
    sem_wait(&semE); // wait
    usleep((rand() % 500)  * 1000);
    printf("E");
    sem_post(&semA); // signal
   }

void* procF (void * x){ // D
    sem_wait(&semA); // wait
    sem_wait(&semF); // wait
    usleep((rand() % 500)  * 1000);
    printf("F");
   }

int main(){
   sem_init(&semA, 0, 0); // init(a,0) 
   sem_init(&semB, 0, 0); // init(b,0)
   sem_init(&semC, 0, 0); // init(c,0)
   sem_init(&semD, 0, 0); // init(d,0)
   sem_init(&semE, 0, 0); // init(e,0)
   sem_init(&semF, 0, 0); // init(f,0)
   
   pthread_t tA,tB,tC,tD,tE,tF;
   pthread_attr_t attr;
   pthread_attr_init(&attr);
   pthread_create(&tA,&attr,procA, NULL);
   pthread_create(&tB,&attr,procB, NULL);
   pthread_create(&tC,&attr,procC, NULL);
   pthread_create(&tD,&attr,procD, NULL);
   pthread_create(&tE,&attr,procE, NULL);
   pthread_create(&tF,&attr,procF, NULL);
   
   pthread_join(tA, NULL);
   pthread_join(tB, NULL);
   pthread_join(tC, NULL);
   pthread_join(tD, NULL);
   pthread_join(tE, NULL);
   pthread_join(tF, NULL);
   
   printf("\n");

   // https://stackoverflow.com/questions/37504018/how-to-sleep-a-process-for-a-vary-interval-of-miliseconds
   
   return 0;
}