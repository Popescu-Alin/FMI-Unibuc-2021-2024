import collections
def RezolvareA(numCourses,prerequisites):
        #prelucrez datele de intrare
        def citireGraf(li,n):
            lista={}
            for x in range(0,n):
                lista[x]=[]
            #Transform din vector de muchii in lista de adiacenta
            #stim ca pentru a unrma cursul j trebuie urmat prima data cursu i atunci din [j,i] voi memora [i,j] 
            for muchie in li:
                nod1,nod2=[int(x) for x in muchie]
                lista[nod2].append(nod1)
            
            return lista

        n=numCourses
        graf=citireGraf(prerequisites,n)

        viz=[0]*(n)
        stiva=collections.deque()
        global ciclu
        ciclu=0
        # se bazeaza pe DFS,
        #vom intorduce un nod in coada atunci cand toti vecini lui sunt vizitati
        def TS(lista,start):
            global ciclu
            if(ciclu==1):
                return 
            viz[start]=1
            for x in lista[start]:
                if(viz[x]==0):
                    TS(lista,x)
                elif(viz[x]==1):
                    ciclu=1
            viz[start]=2
            stiva.appendleft(start) #folosim apendleft ca la afisare sa nu mai folosim reverse
              
        for x in range(0,n):
            if(viz[x]==0):
                TS(graf,x)
        
        if(ciclu==1):
            return []
        
        return list(stiva)


print (RezolvareA(2,[[1,0]]))

#Complexitate:
#   -Prelucrarea datelor : O(n+m)
#   -Sortarea Topologica este o modificare a DFS-ului si are complexiatete O(n+m)
#   -Complexitate Totala : O(n+m).

def RezolvareB(numCourses,prerequisites):
        #prelucrez datele de intrare
        def citireGraf(li,n):
            lista={}
            for x in range(0,n):
                lista[x]=[]
            #Transform din vector de muchii in lista de adiacenta
            #stim ca pentru a unrma cursul j trebuie urmat prima data cursu i atunci din [j,i] voi memora [i,j] 
            for muchie in li:
                nod1,nod2=[int(x) for x in muchie]
                lista[nod2].append(nod1)
            
            return lista

        n=numCourses
        graf=citireGraf(prerequisites,n)

        viz=[0]*(n)
        T=[-1]*(n) #memorez in vectorul de tati arborele format in urma parcurcerii
                #cu ajutorul lui o sa memorez si un posibil ciclu.
        stiva=collections.deque()
        global ciclu
        ciclu=-1
        # se bazeaza pe DFS,
        #vom intorduce un nod in coada atunci cand toti vecini lui sunt vizitati
        #In plus vom adauga si algoritmul de detectare de cicli.
        #0 reprezinta nevizitat, 1 ca e vizitat dar nu s a terminat explorarea, 2 ca e viz si finalizata explorarea
        def TS(lista,start):
            global ciclu
            if(ciclu!=-1):
                return 
            viz[start]=1
            for x in lista[start]:
                if(viz[x]==0):
                    T[x]=start
                    TS(lista,x)
                elif(viz[x]==1):
                    ciclu=start
                    T[x]=start
            viz[start]=2
            stiva.appendleft(start) #folosim apendleft ca la afisare sa nu mai folosim reverse
              
        for x in range(0,n):
            if(viz[x]==0):
                TS(graf,x)
        
       
        #in variabila ciclu voi avea memorat nodul care a inchis un ciclu

        if(ciclu==-1): #daca nu am circuite retiurnez lista vida
            return []
        
        TraseuCiclu=[ciclu] #introduc in traseu elemetul de la care pornesc.
        i=T[ciclu] 
        while(i!=ciclu):
            TraseuCiclu.append(i)
            i=T[i]
        TraseuCiclu.append(ciclu)
        return TraseuCiclu
        

            

print (RezolvareB(2,[[1,0]]))


#Complexitate:
#   -Prelucrarea datelor : O(n+m)
#   -Sortarea Topologica este o modificare a DFS-ului si are complexiatete O(n+m)
#   -Afisare ciclu + formare O(2n)
#   -Complexitate Totala : O(n+m).