import collections
def Rezolvare(numCourses,prerequisites):
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
        

            

print (Rezolvare(2,[[1,0],[0,1]]
))




        

