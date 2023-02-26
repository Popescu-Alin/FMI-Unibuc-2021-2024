#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/errno.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

/* programul compileaza cu 

gcc lab5-SO-bun.c -o lab5-SO-bun -lrt
./lab5-SO-bun 9 16 25 36 

*/
                      
 
int main(int argc, char* argv[])
{
 
    //este creat obiectul de memorie partajata 
    
    //descriptor cu care ne folosim sa scriem
    char* shm_name="shared_memory";
    
    //zona de memorie creata cu numele shared_memory 
    //o_creat -> in caz ca nu exista il creeaza 
    //o_rdwr -> citire si scriere 
    // s_irusr | s_iwusr ofera drepturi asupra lui doar utilizatorului care l-a creat
    int shm_fd=shm_open(shm_name, O_RDWR|O_CREAT, S_IRUSR | S_IWUSR);
    
    //nu s a putut crea zona de memorie
    if(shm_fd<0)
    {
        perror("eroare la deschidere\n");
        return errno;
    }
 
    //fiecare proces copil va avea o zona de memorie
    //de marimea unei pagini unde va putea scrie
    
    int page_size=getpagesize();
    int shm_size=page_size*argc;
    
    //ii defineste dimensiunea zonei de memorie de la 0 la nr de argumente*page_size
    if(ftruncate(shm_fd, shm_size)==-1)
    {
        perror("eroare\n");
        
        //daca nu s a creat -> stergem obiectul 
        shm_unlink(shm_name);
        return errno;
    }
    printf("Starting Parent: %d\n", getpid());
    
    //pointer catre zona de memorie 
    char *shm_ptr;
    for(int i=1; i<argc; i++)
    {
        //la fiecare proces copil ii transmit o zona de memorie aferenta
        //PROT_WRITE -> poate sa scrie 
        //MAP_SHARED -> memoria e impartita cu restul proceselor
        //shm_fd  -> zona de memorie alocata de noi
        shm_ptr=mmap(0, page_size, PROT_WRITE, MAP_SHARED, shm_fd, (i-1)*page_size);
        //indica catre o parte din page_size bytes, incepand de la (i-1)*page_size bytes 
        
        //eroare daca nu s-a putut mapa memoria
        if(shm_ptr==MAP_FAILED)
        {
            perror("error in truncating the memory\n");
            
            //stergem obiectul 
            shm_unlink(shm_name);
            return errno;
        }
        
        //se va creea un proces copil pentru fiecare task 
        pid_t pid=fork();
        
        if(pid<0)
        {
            perror("nu am putut crea procesul parinte\n");
            return errno;
        }
 
        else if(pid==0)
        {
            //ne aflam in procesul copil 
            
            //transformam argumentul primit in intreg pt a putea face operatii cu el 
            int x=atoi(argv[i]);
            
            //adauga in memorie 
            //shm_ptr -> pozitia (array) de unde incepe sa scriem 
            //si dupa ce scrie -> intoarce nr de bytes scrisi 
            
            //shm_ptr va fi incrementat cu nr de bytes scrisi 
            shm_ptr+=sprintf(shm_ptr, "%d: %d ", x, x); 
            
            //ipoteza lui collatz 
            while(x!=1)
            {
                if(x%2==0) x/=2;
                else x=3*x+1;
                
                shm_ptr+=sprintf(shm_ptr, "%d ", x);
            }
            printf("Done Parent %d Me %d\n",  getppid(), getpid());
            return 1;
        }
        
        //eliberam zona de memorie 
        munmap(shm_ptr, page_size);
    }
 
    for(int i=1; i<argc; i++) 
       // procesul parinte va astepta ca toate
       // procesele copil sa fie finalizare
        wait(NULL);
 
     //dezalocam memorie 
    for(int i=1; i<argc; i++)
    {    
        //shm_fd  -> zona de memorie alocata de noi
        //MAP_SHARED -> memoria e impartita cu restul proceselor
        shm_ptr=mmap(0, page_size, PROT_READ, MAP_SHARED, shm_fd, (i-1)*page_size);
        //am scris pe ecran tot ce era in zona de memorie a copilului i 
		printf("%s\n", shm_ptr);
		//eliberam zona de memorie 
		munmap(shm_ptr, page_size);
	}
	
	
   printf("Done Parent. Parent= %d,  Me=%d\n", getppid(), getpid());
   
   // stergem obiectul 
   shm_unlink(shm_name);
 
    return 0;
}
