/*
Rescrieti programul Hello World de data trecuta
folosind numai functii sistem
*/

// programul va fi compilat astfel: gcc lab2-ex1.c -o lab2-ex1
// programul va fi apelat astfel: ./lab2-ex1

#include <stdio.h>
#include <unistd.h>



int main ()
{ 

    //functie de sistem prin care scriem hello world 
    // 15 dimensiunea textului
    write(1, "Hello, World!\n", 15);
    return 0;
}
