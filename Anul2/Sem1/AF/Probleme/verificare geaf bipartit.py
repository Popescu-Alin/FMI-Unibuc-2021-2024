import collections
def RezolvareA(n,dislikes):
        #prelucrez datele de intrare
        def citireGraf(li,n):
            lista={}
            for x in range(1,n+1):
                lista[x]=[]
            #Transform din vector de muchii in lista de adiacenta
            for muchie in li:
                nod1,nod2=[int(x) for x in muchie]
                lista[nod1].append(nod2)
                lista[nod2].append(nod1)
            
            return lista


        viz=[0]*(n+1)
        culoare=[0]*(n+1)
        #problema se reduce la a verifica daca graful este bipartit
        #vom folosi parcurgerea in latime 
        #vom avea un vector care memoreaz 2 valori (-1 si 1)
        #la fiecare pas  cand vizitam un nod vom schimba culoare astfel cuoarea fiului este diferita de culoarea tatalui
        #daca nodul este deja vizitat vom verifica daca nodul tata si nodul fiu au culor diferite ,in cazul in care nu sunt diferite inseamna ca nu poate fi bipartit
        #in alte cuvinte , in arborele format de parcurgere nu trebuie sa existe muchii intre nodurile aflate pe acelas nivel.
        def Parcurgere(lista,n,start):
            viz[start]=1
            culoare[start]=1
            coada=collections.deque()
            coada.append(start)
            while(coada):
                curent=coada.popleft()
                for vecin in lista[curent]:
                    if(viz[vecin] ==0 ):
                        coada.append(vecin)
                        viz[vecin]=1
                        culoare[vecin]=-culoare[curent]
                    elif (viz[vecin]!=0 and culoare[vecin]==culoare[curent]):
                        return 0
            return 1


        lista=citireGraf(dislikes,n)
        
        #aplicam algoritmul cat timp avem noduri nevizitate.
        #Daca avem mai multe componenete conexe vom verifiaca pt fiecare daca sunt bipartite 
        #daca cel putin unul nu este bipartit => graful nu e bipartit.
        for i in range(1,n+1):
            if(viz[i]==0 and Parcurgere(lista,n,i)==0):
                return False
                
        
        return True
        

print (RezolvareA(4,[[1,2],[1,3],[2,4]]))


#Complexitate:
#   -Prelucrarea datelor : O(n+m)
#   -Parcurgerea are complexiatete O(n+m)
#   -Complexitate Totala : O(n+m).



def RezolvareB(n,dislikes):
        def citireGraf(li,n):
            
            lista={}
            for x in range(1,n+1):
                lista[x]=[]
            
            for muchie in li:
                nod1,nod2=[int(x) for x in muchie]
                lista[nod1].append(nod2)
                lista[nod2].append(nod1)
            
            return lista


        viz=[0]*(n+1)
        culoare=[0]*(n+1)
        def Parcurgere(lista,n,start):
            viz[start]=1
            culoare[start]=1
            coada=collections.deque()
            coada.append(start)
            while(coada):
                curent=coada.popleft()
                # print(curent)
                for vecin in lista[curent]:
                    if(viz[vecin] ==0 ):
                        coada.append(vecin)
                        viz[vecin]=1
                        culoare[vecin]=-culoare[curent]
                    elif (viz[vecin]!=0 and culoare[vecin]==culoare[curent]):
                        return 0
            return 1


        lista=citireGraf(dislikes,n)
        
        for i in range(1,n+1):
            if(viz[i]==0 and Parcurgere(lista,n,i)==0):
                return []
                
        #algoritmul este acelas ca la a)
        # petru a putea impartii cele 2 grupe  ne vom folosi de cele 2 culori folosite in verificarea daca graful este bipartit
        lista1=[]
        lista2=[]
        
        for i in range(1,n+1):
            if(culoare[i]==-1):
                lista1.append(i)
            else:
                lista2.append(i)
        return (lista1,lista2)

print (RezolvareB(4,[[1,2],[1,3],[2,4]]))



        

