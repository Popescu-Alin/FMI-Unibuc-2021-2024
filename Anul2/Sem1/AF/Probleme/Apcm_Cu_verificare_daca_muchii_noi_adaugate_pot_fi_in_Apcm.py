
def Kruskal(lista,n):
    #sortam dupa cost
    lista.sort(key=lambda x:x[2])

    #vectorul de tati
    tata=[0]*(n+1)
    #vectorul de inaltimi
    h=[0]*(n+1)

    # determi  reprezentatntul nodului x si fac compresie de cale
    def find(x):
        if tata[x]!=0 :
            tata[x]=find(tata[x])
            return tata[x]
        return x

    # unesc cei 2 arbori 
    def union(x,y):
        r1=find(x)
        r2=find(y)
        if h[r1]>h[r2]:
            tata[r2]=r1
        elif h[r2]>h[r1]:
            tata[r1]=r2
        else:
            tata[r2]=r1
            h[r1]+=1

    #Muchii arbore
    Sol=[]
    #tin minte cate muchii are arborele
    nr=0
    #retin costul
    total=0
    for nod1,nod2,cost in lista:
        if find(nod1)!=find(nod2):
            Sol.append((nod1,nod2,cost))
            total+=cost
            union(nod1,nod2)
            nr+=1
            if nr==n-1:
                break
    
    return Sol,total


f=open('online.in','r')
g=open('online.out','w')

n,m=[int(x) for x in f.readline().split()]
global lista
lista=[]#lista de muchii
for _ in range(m):
    nod1,nod2,cost=[int(x) for x in f.readline().split()]
    lista.append((nod1,nod2,cost))

#calculez apcm-ul si costul sau
lista,total=Kruskal(lista,n)

g.write(str(total) + "\n")#scriu costu in fisier
k=int(f.readline())
for _ in range(k):#citesc muchia si calculez noul drum.
    nod1,nod2,cost=[int(x) for x in f.readline().split()]
    lista.append((nod1,nod2,cost))
    #calculez noul apcm si costul sau
    lista,total=Kruskal(lista,n)
    g.write(str(total) + "\n")#scriu costu in fisier
        
f.close()
g.close()
