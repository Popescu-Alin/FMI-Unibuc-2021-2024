/*
Scrieti un program care primeste un sir de caractere la intrare ale carui caractere 
le copiaza in ordine inversa si le salveaza intr-un sir separat. Operatie de inversare
va avea loc intr-un thread separat.Rezultatul va fi obtinut cu ajutorul functiei pthread_join
*/

// programul va fi compilat astfel: gcc lab6-ex1.c -o lab6-ex1 -pthread
// programul va fi apelat astfel: ./lab6-ex1 hello

#include <pthread.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* reverse(void* arg)
{
    //dimensiunea cuvantului 
    int len = strlen(arg);
    
    //aloca memorie pentru noul sir 
    char* new_string = (char*)malloc(len);

    // inversam sirul printr-o parcurgere
    for(int i = 0; i < len; ++i)
        new_string[i] = ((char*)arg)[len - i - 1];

    //returnam noul sir 
    return new_string;
}



int main(int argc, char* argv[])
{
    

    // se creeaza un nou thread
    pthread_t thr;

    // functia pthread_create va returna 1 daca
    // nu se va putea crea un thread
    
    // lansarea unui nou fir de executie cu argumentul thr -> thread
    // reverse -> functia 
    // argv[1] -> string ul pe care il trimitem 
    // NULL -> atributele default ale sistemului de operare
    if (pthread_create(&thr, NULL, reverse, argv[1]))
    {
        perror(NULL);
        return errno;
    }

 
    //returneaza rezultatul
    void* result;
    
    // cu functia pthread_join se asteapta
    // finalizarea thread-ului specificat
    if (pthread_join(thr, &result))
    {
        perror(NULL);
        return errno;
    }

    // afisam rezultatul dupa terminarea threadului
    printf("%s\n", (char *)result);

    //dezaloca memorie 
    free(result);

    return 0;                       
}
