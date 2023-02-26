/*
Scrieti un program mycp care sa primeasca la intrare in primul
argument un fisier sursa pe care sa-l copieze intr-un alt
fisier cu numele primit in al doilea argument

// programul va fi compilat astfel: gcc lab2-ex2.c -o lab2ex2
// programul va fi apelat astfel: ./lab2-ex2 file1 file2

*/

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>


int main(int argc, char *argv[])
{
        //cate argumente avem si ce argumente avem 
	struct stat buffer;
	//buffer punem cate elemente avem 
	int fptrR;
	int status=stat(argv[1],&buffer);
	//dimensiunea bufferului 
	int size=buffer.st_size;
	
	//deschidem fisierul sursa
	fptrR=open(argv[1],O_RDONLY);
	
	char s[size];
	int i=0;
	int fptr;
	//deschidem al doilea fisier 
	fptr=open(argv[2],O_WRONLY);
	while (i<size)
	{
	  //citim un byte si il bagam in s
	  //byte reprezinta un caracter 
	  read(fptrR,s,1);
	  
	  //am copiat ceea ce se afla din primul fisier in al doilea 
	  // scriem caracterul 
	  write (fptr,s,1);
	  i++;
	} 
	

	return 0;
}



