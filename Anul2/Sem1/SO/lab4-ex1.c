//Prob 1 

/*
Creati un proces nou folosind fork(2) si afisati fisierele din directorul
curent cu ajutorul execve(2). Din procesul initial afisati pid-ul propriu
si pid-ul copilului. 

programul va fi compilat cu gcc lab4-ex1.c -o lab4-ex1
                            ./lab4-ex1
*/

//fork- creeaza procese noi
//cu ajutorul lui execve afisam fisierele din directorul curent


#include<sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>

int main()

{ 
  //se creaza un nou proces copil 
  //procesul copil are un ID ( denumit si PID) diferit de cel al parintelui 
  pid_t pid= fork();
  
  if (pid<0)
  //errno variabila globala care retine codul pentru eroare 
      return errno;
      
  else if (pid==0)
     {
      //aici ne aflam in procesul copil deoarece copilul primeste valoarea 0
      printf("Child %d Me %d\n", getppid(), getpid()); 
      
      // argumentele programului sunt puse in argv.
      //primul argument este calea absoluta, iar lista se incheie cu null->sf listei
      char *argv[] =  {"ls", NULL};
      //functia ls este definita in /bin
      
      //ne asiguram ca procesul copil are propria stiva si prop segm de memorie
      //prin intermediul ei, procesul nu mai revine in programul initial doar daca 
      //intalneste o eroare 
     
      execve ("/bin/ls", argv, NULL);
      
      //raspuns
      perror(NULL);
      }
      
  else 
  
  {   // parintele primeste pid-ul copilului 
      // aici ne aflam in procesul parinte
      printf("Parent PID = %d, Child PID = %d \n", getpid(), pid);
      
      //procesul parinte asteapta finalizarea copilului
      wait(NULL);
      printf("Child %d finished\n", pid);
  }

} 

