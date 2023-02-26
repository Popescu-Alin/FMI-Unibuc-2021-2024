

/*
Scrieti un program care gestioneaza accesul la un numar finit de resurse.
Mai multe fire de executie pot cere concomitent o parte din resurse pe
care le vor da inapoi o data ce nu le mai sunt utile.
*/

// programul va fi compilat astfel: gcc lab7ex1.c -o lab7-ex1 -pthread
// programul va fi apelat astfel: ./lab7-ex1

/*
Adesea, in programele cu mai multe fire de executie si procese avem nevoie ca
o singura entitate sa execute un numar de instructiuni la un moment de timp
dat. Aceasta zona in care are voie un singur proces sau thread se numeste zona
critica 
*/

#include <unistd.h>
#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <stdlib.h>

#define MAX_RESOURCES 5
int resources = MAX_RESOURCES;

//variabila mutex se pune in memoria globala
//obiectul cel mai des folosit pentru asigurarea accesului exclusiv intr-o zona critica
pthread_mutex_t mutex;
pthread_t *threads;

//cand un thread doreste sa obtina un nr de resurse, acesta apeleaza decrease_count
int decrease_count(int count){
    //inchide firul de executie 
    //cand mutexul este inchis inseamna ca un thread detine dreptul exclusiv de executie 
    //asupra zonei critice pana ce decide sa renunte la acest drept 
    pthread_mutex_lock(&mutex);
    
    //dam resurse 
    if(resources >= count){
        resources = resources - count;
        printf("Got      : %d, Remaining Resources: %d\n", count, resources);
        pthread_mutex_unlock(&mutex);
    }
    else{
        printf("Not enough resources. Got : %d, Remaining Resources: %d\n", count, resources);
        //pentru a elibera mutexul
        pthread_mutex_unlock(&mutex);
        return -1;
    }

    return 0;
}

//cand resursele nu-i mai sunt necesare apeleaza increase_count
int increase_count(int count){
    //inchide firul de executie
    pthread_mutex_lock(&mutex);
    resources += count;
    printf("Released : %d, Remaining Resources: %d\n", count, resources);
    //elibereaza mutexul
    pthread_mutex_unlock(&mutex);
    return 0;
}

//apelam cele 2 functii
void* thread_routine(void* arg){
    //primeste un argument de tip int
    int* argument = (int*) arg;
    int count = *argument;
    //daca nu are suficiente resurse -> nu poate sa execute
    //in cazul nostru , are suficiente resurse 
    if(decrease_count(count)>=0){
 
        increase_count(count);
    }
    //elibereaza zona de memorie
    free(argument);
    return NULL;
}

int main(){
    
    //alocam 5 threaduri 
    threads = (pthread_t*) malloc(MAX_RESOURCES * sizeof(pthread_t));

    if(pthread_mutex_init(&mutex, NULL)){
        perror("Error at pthread_mutex_init\n");
        return errno;
    }

    //creaza 5 fire de executie diferite 
    for(int i = 0; i < 5; ++i){
        int* argument;
        argument = (int*) malloc(sizeof(int));
        *argument = i;
        if(pthread_create(&threads[i], NULL, thread_routine, argument)){
            perror("Error at pthread_create\n");
            return errno;
        }
    }
    
    //se unesc
    for(int i = 0; i < 5; ++i){
        if(pthread_join(threads[i], NULL)){
            perror("Error at pthread_join\n");
            return errno;
        }
        
    }
    //cand nu mai avem nevoie de obiectul de tip mutex, eliberam resursele ocupate 
    if(pthread_mutex_destroy(&mutex)){
        perror("Error at pthread_mutex_destroy\n");
        return errno;
    }
    free(threads);
    return 0;


}
