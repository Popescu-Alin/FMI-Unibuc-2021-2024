#salvam ca lista de muchii.
n=6
#lista de muchii (nod1,nod2,cost)
lista=[(1,2,15),(1,3,11),(2,4,3),(2,5,10),(2,6,5),(3,5,8),(3,6,9),(4,6,2),(5,6,20)]
#sortam dupa cost
lista.sort(key=lambda x:x[2])
m=len(lista)

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
for nod1,nod2,cost in lista:
    if find(nod1)!=find(nod2):
        Sol.append((nod1,nod2))
        union(nod1,nod2)
        nr+=1
        if nr==n-1:
            break

print(Sol)

