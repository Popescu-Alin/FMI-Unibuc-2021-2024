

//Prob 3
/*
 Implementati un program care sa testeze ipoteza Collatz pentru mai multe
 numere date. Pornind de la un singur proces parinte, este creat cate un
 copil care se ocupa de un singur numar. Parintele va astepta sa termine
 executia fiecare copil. Se vor folosi getpid() si getppid().
 
 // programul va fi compilat astfel: gcc lab4-ex3.c -o lab4-ex3
// programul va fi apelat astfel: ./lab4-ex3 9 16 25 36
*/

#include<sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>


int main(int args, char *argv[])

{
  for (int i=1;i<=args;i++)
  {
  //se creaza cate un proces copil pentru fiecare numar primit ca argument 
  pid_t pid= fork();
  
  if (pid<0)
      return errno;
      
  else if (pid==0)
     {
       //ne aflam in procesul copil 
       
       //transformam argumentul primit in intreg 
       //pentru a putea face operatii cu el 
       int n=atoi(argv[i]);
       
       //printam 
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
      
      printf("\n");
      
      //se termina procesul copil
      return 0;
      }
  }
  
  for (int i = 1; i < args; i++)
  
      // procesul parinte va astepta ca toate
      // procesele copil sa fie finalizare
      wait(NULL);
      
  printf("Done Parent %d Me %d \n", getppid(),getpid());

} 
