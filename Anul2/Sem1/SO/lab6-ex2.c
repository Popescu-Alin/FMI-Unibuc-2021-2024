/*
Scrieti un program care sa calculeze produsul a doua matrice date
de dimensiuni compatibile unde fiecare element al matricei
rezultate este calculat de catre un thread distinct.
*/

// programul va fi compilat astfel: gcc lab6-ex2.c -o lab6-ex2 -pthread
// programul va fi apelat astfel: ./lab6-ex2

#include <stdio.h>
#include <errno.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

// matrice patratica cu i si j -> linii coloane
int n = 3, i, j;

void* multiply(void* v)
{
    // convertim vectorul pasat ca
    // argument intr-un pointer de int
    int* elem = (int*)v;

    // alocam memorie pentru
    // calculul elementului
    int* c = (int*)malloc(sizeof(int));

    //calculam elem, prin produs 
    for(int i = 0; i < n; i++)
	c[0] += elem[i] * elem[n + i];
     
    //returnam elem   
    return c;
}



int main()
{
    // declararea matricilor si a vectorului de elemente
    int matrice1[n][n], matrice2[n][n], matrice_final[n][n], v[2*n + 1];
    
    for (i=0; i<n;i++)
       for (j=0;j<n;j++)
         matrice1[i][j]=i+j;
    //o sa fie de forma 0 1 2 
                      //1 2 3
                      //2 3 4
                      
    for (i = 0; i < n; i++)
	for (j = 0; j < n; j++)
	   matrice2[i][j] = i+j;   
    //o sa fie de forma 0 1 2 
                      //1 2 3
                      //2 3 4

    // se afiseaza rezultatul 
    void* result;
    // se creaza un nou thread
    pthread_t thr;
    for (i = 0; i < n; i++)
       for (j = 0; j < n; j++)
        {
	    int l, k = 0;

            // punem in vector elementele necesare pentru
            // a calcula elementul cu indicii i si j
	    for (l = 0; l < n; l++)
		v[k++] = matrice1[i][l];

	    for(l = 0; l < n; l++)
		v[k++] = matrice2[l][j];
			
            // se creeaza un thread nou pentru
            // calculul fiecarei element al matricei
            if(pthread_create(&thr, NULL, multiply, v))
            {
		 perror(NULL);
		 return errno;
	    }
			
            // se asteapta finalizarea threadurilor
            if(pthread_join(thr, &result))
            {
		perror(NULL);
		return errno;
	    }
			
            // salvam in noua matrice elementul
            // calculat cu ajutorul unui thread
            matrice_final[i][j] = *(int*)result;
			
            // eliberam memoria
            free(result);
            
      }

    // afisarea matricei finale
    for (i = 0; i < n; i++)
     {
        for (j = 0; j < n; j++)
	    printf("%d ", matrice_final[i][j]);
	printf("\n");
    }

    return 0;
}
