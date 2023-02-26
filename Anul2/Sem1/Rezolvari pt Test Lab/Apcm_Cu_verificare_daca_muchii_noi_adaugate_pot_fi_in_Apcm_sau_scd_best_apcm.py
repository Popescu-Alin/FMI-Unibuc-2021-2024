
def Kruskal(lista,n,x=-1,y=-1,uni=False):
   
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

     #functia primeste ca parametrii lista , n 2 noduri x,y si uni=> daca uni e true uneste cele 2 noduri.
    if uni:
        union(x,y)
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
    if uni==False:
        return Sol,total  
    else:
        return total


f=open('apm2.in','r')
g=open('apm.out','w')

n,m,q=[int(x) for x in f.readline().split()]
global lista
lista=[]#lista de muchii
for _ in range(m):
    nod1,nod2,cost=[int(x) for x in f.readline().split()]
    lista.append((nod1,nod2,cost))

#calculez apcm-ul si costul sau
lista,total=Kruskal(lista,n)


for _ in range(q):#citesc nodurile si calculam ce cost ar trebui sa aiba muchia
    nod1,nod2=[int(x) for x in f.readline().split()]
    
    #calculez   costul daca muchiar dintre nod1 nod2 ar fi 0
    totalPartial=Kruskal(lista,n,nod1,nod2,True)
    g.write(str(total-totalPartial-1) + "\n")#Muchiar ceruta ar trebui sa fie cu 1 mai mica ca costul apcm-ului initial
        
f.close()
g.close()
