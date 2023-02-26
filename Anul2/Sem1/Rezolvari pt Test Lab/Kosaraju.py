import collections

def citireGraf():
    f=open("ctc.in",'r')
    n,m=[int(x) for x in f.readline().split(" ")]
    lista={}
    grafTranspus={}
    for x in range(1,n+1):
        lista[x]=[]
        grafTranspus[x]=[]
    
    #simultan cu citirea grafui o sa memorez si graful transpus.

    for i in range (m):
        nod1,nod2=[int(x) for x in f.readline().split(" ")]
        lista[nod1].append(nod2) #graful
        grafTranspus[nod2].append(nod1) #graful transpus
    
    return(lista,grafTranspus,n)


#memorez in stiva parcurgerea 
stiva=collections.deque()
#citesc graful
graf,grafTranspus,n=[x for x in citireGraf()]
#vectorul de vizitati
viz=[0]*(n+1)

def ParcurgereAdancime(lista,start):
    viz[start]=1
    
    for vecin in lista[start]:#ma plimb prin lista de vecini a nodului de start
        if(viz[vecin] ==0 ):# daca gasesc vecin nevizitat reapelez
            ParcurgereAdancime(lista,vecin)
    stiva.append(start)



componente={} #voi memora in dictionar componentele conexe

def DetCompTariConexe(lista,start,nr):
    viz[start]=nr
    componente[nr].append(start) #adaug nodul in componenta conexa 
    for vecin in lista[start]:#ma plimb prin lista de vecini a nodului de start
        if(viz[vecin] ==0 ):# daca gasesc vecin nevizitat reapelez
            DetCompTariConexe(lista,vecin,nr)


for i in range(1,n+1):
    if(viz[i]==0):
        ParcurgereAdancime(graf,i)


#golesc vectorul de vizitare
viz=[0]*(n+1)
total=0# numarul de componenete conexe
while(stiva):
    x=stiva.pop()
    if viz[x]==0:
        total=total+1
        componente[total]=[]
        DetCompTariConexe(grafTranspus,x,total)

#afisez elementele:

with open("ctc.out",'w') as g:
    g.write(f'{total} \n')
    for i in range(total):
        for x in componente[i+1]:
            g.write(f'{x} ')
        g.write('\n')

#Complexitate:
#   -Prelucrarea datelor + crearea grafului transpus : O(n+m)
#   -Algoritmul se bazeaza pe 2 parcurgeri de complexiatete O(n+m) fiecare
#   -Afisarea are complexitate n
#   -Complexitate Totala : O(n+m).