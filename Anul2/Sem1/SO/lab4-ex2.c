//Prob 2
/* Ipoteza Collatz spune ca plecand de la orice numar natural daca aplicam
repetat urmatoarea operatie
n 7 →
{n/2 mod (n, 2) = 0
3n + 1 mod (n, 2) 6 = 0
sirul ce rezulta va atinge valoarea 1. Implementati un program care
foloseste fork(2) si testeaza ipoteza generand sirul asociat unui numar
dat ın procesul copil. 

Programul va fi compilat astfel gcc lab4-ex2.c -o lab4-ex2
                                ./ lab4-ex2 24 
*/

#include<sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>

int main(int args, char *argv[])

{  
  //se creaza un nou proces copil 
  //procesul copil are un ID ( denumit si PID) diferit de cel al parintelui 
  pid_t pid= fork();
  
  if (pid<0)
  //errno variabila globala care retine codul pentru eroare 
      return errno;
      
  else if (pid==0)
     {
       //ne aflam in procesul copil 
       
       //transformam argumentul primit in intreg
       //pt a putea face operatii cu el 
       int n=atoi(argv[1]);
       
       //afisam numerele 
       printf("%d: %d ", n, n);
       
       //ipoteza lui collatz
       while (n!=1)
       {
       if (n%2==0)
           n=n/2;
       else 
           n=3*n+1;
      printf("%d " , n);
      }
      }
  else 
  {
      //procesul parinte asteapta finalizarea copilului
      wait(NULL);
      printf("Child %d finished\n", pid);
  }

} 
