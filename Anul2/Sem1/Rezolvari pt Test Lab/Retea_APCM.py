
def RezolvareA():
        import math
        import heapq
        listaCentrale=[] #memorez poz centralelor
        listaBlocuri=[] #po blocurilor
        with open("retea2.in",'r') as f:
            n,m=[int(x) for x in f.readline().split()]
            for x in range(n):
                x,y=[int(x) for x in f.readline().split()]
                listaCentrale.append((x,y))
            
            for i in range(m):
                x,y=[int(x) for x in f.readline().split()]
                listaBlocuri.append((x,y))
            
        listaToate=listaCentrale+listaBlocuri
        viz=[False]*(m+n) #si blocurile si centrale sunt nealimentate 
        tata=[None] * (n+m) #vectorul de tati
        d=[0]*n +[float('inf')]*m #pt centrale distanta e 0,
        heap=[(d[i],i) for i in range(n)] #introduc intr-un heap elementele centralele cu d[centrala]=0

        nr=0 # numarul de elemente introduse
        total=0 #distanta totala a retelei

        def distanta(p1,p2):
            return math.sqrt( (p1[0]-p2[0])**2 +(p1[1]-p2[1])**2 )

        
        while heap and nr!=n+m: # cat timp nu am nu am unit toate blocurile 
            dist,nod=heapq.heappop(heap)
            if(viz[nod]==False):
                for bloc in range(n,n+m): #unim doar centra-bloc sau bloc-bloc
                    if viz[bloc]==False:
                        w=distanta(listaToate[nod],listaToate[bloc])
                        if d[bloc]>w:
                            d[bloc]=w
                            tata[bloc]=nod
                            heapq.heappush(heap,(d[bloc],bloc))
                viz[nod]=True
                nr+=1
                total+=dist
                            
        return total

print(RezolvareA())

# complexiate : n*(n+m)