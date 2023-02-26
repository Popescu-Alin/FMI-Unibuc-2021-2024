import collections

def citireGraf():
    with open("graf.in",'r') as f:
        n,m=[int(x) for x in f.readline().split(" ")]
        lista={}
        for x in range(0,n+1):
            lista[x]=[]
        #citim graful si il salvam in lista de vecini  
        for i in range (m):
            nod1,nod2=[int(x) for x in f.readline().split(" ")]
            lista[nod1].append(nod2)
            lista[nod2].append(nod1)
        
        #citim lista de puncte de control
        pControl=[int(x) for x in f.readline().split(" ")]
        #adaug un nod 0 (consider ca in graful initial nu exista nodul 0) care are ca vecini doar punctele de control
        lista[0]=pControl
        #adaug pe 0 ca vecin al punctelor de control
        for x in pControl:
            lista[x].append(0)
        return(lista,n)


#parcurgerea in latime
def Parcurgere(lista,n,start):
    viz=[0]*(n+1)
    dist=[0]*(n+1)
    viz[start]=1
    dist[start]=0
    coada=collections.deque()
    coada.append(start)
    while(coada):
        curent=coada.popleft()
       
        for vecin in lista[curent]:
            if(viz[vecin]==0 ):
                coada.append(vecin)
                viz[vecin]=1
                dist[vecin]=dist[curent]+1
                
    
    return dist


lista,n=[x for x in citireGraf()]


#facem parcurgerea in latime pornind din varful auxiliar 0
listaDistanta=Parcurgere(lista,n,0)

#pentru fiecare nod vom afisa distanta -1 (-1 pentru a elimina muchia adaugata de nodul auxilia)
with open("graf.out",'w') as g:
    for i in range(1,n+1):
        g.write(f'{listaDistanta[i]-1} ' ) 
        


#Complexitate: Parcurgerea in latime are cimplexitate O(n+m)
#               Functia de citire a greafului are complexitate O(n+m)
#               Afisarea are complexitatea O(n)
#               Complexitate totala : O(n+m)

