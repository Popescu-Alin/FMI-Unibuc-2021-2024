

cuvinte=[]

with open('cuvinte.in','r') as f:
    while line:=f.readline():
        line.replace('\n','')
        cuvinte.extend(line.split())

print(cuvinte)
n=len(cuvinte)
k=int(input("introduceti un k: "))



def distantaLevenshtein(cuv1,cuv2):
    n1=len(cuv1)
    n2=len(cuv2)
    #creez matricea
    matrice=[[None]*(n2+1) for i in range(n1+1)]
    matrice[0][0]=0
    for i in range(n1+1):
        matrice[i][0]=i

    for j in range(n2+1):
        matrice[0][j]=j

    #calculez recursiv elementul de pe pozitia i,j in matrice
    def recursie(i,j):
        if matrice[i][j]!=None:
            return matrice[i][j]
        else:
            if cuv1[i-1]==cuv2[j-1]:
                matrice[i][j]=recursie(i-1,j-1)
                return matrice[i][j]
            matrice[i][j]=1+min(recursie(i-1,j),recursie(i,j-1),recursie(i-1,j-1))
            return matrice[i][j]

    recursie(i,j)
    
    return matrice[n1][n2]


#lista de muchii (id_cuv1,id_cuv2,distanta)
lista=[]
for i in range(n):
    for j in range(i+1,n):
        lista.append((i,j,distantaLevenshtein(cuvinte[i],cuvinte[j])))


#sortam dupa distanta
lista.sort(key=lambda x:x[2])
m=len(lista)

#vectorul de tati modicif cu -1 casa fac diferenta dintre cuvantul cu indicele 0 si factul ca nodul nu are tata
tata=[-1]*n
#vectorul de inaltimi
h=[0]*n

# determi  reprezentatntul nodului x si fac compresie de cale
def find(x):
    if tata[x]!=-1 :
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


nr=0
distanta=0
for i in range(len(lista)):
    nod1,nod2,cost=lista[i]
    if find(nod1)!=find(nod2):
        union(nod1,nod2)
        nr+=1
        if nr==n-k:#daca in arbore sunt n-k muchii=> exista k arbori
            if k!=1:
                distanta=lista[i+1][2]
            break


for i in range(n):
    if tata[i] == -1:#daca nodul e radacina
        for j in range(n) :
            if find(j) == i: #daca nodul j are radacina i
                print(cuvinte[j], end = " ")
        print()

print(distanta)