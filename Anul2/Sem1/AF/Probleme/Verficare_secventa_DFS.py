import collections



def citireDate():
    
    n,m=[int(x) for x in input().split(" ")]
    
    permutare=[int(x) for x in input().split(" ")]

    lista={}

    for x in range(1,n+1):
        lista[x]=[]

    #lista de adiacenta memorata in dictionar    
    for i in range (m):
        nod1,nod2=[int(x) for x in input().split(" ")]
        lista[nod1].append(nod2) 
        lista[nod2].append(nod1)

    return(lista,n,permutare)


#verific daca are vecin nevizitat
#primeste lista de vecin ai unui nod si vectorul de vizitari
def AreVeciniNevizitati(lista,viz):
    for x in lista:
        if(viz[x]==0):
            return True
            
    return False



lista,n,permutare=[x for x in citireDate()]
#initializez vectorul cu 0
viz=[0]*(n+1)
#imi iau o stiva in care bag elementul 1 
#voi emula stiva recursiva a parcrgerii
stiva=collections.deque()
stiva.append(1)
i=1
viz[1]=1
sem=1
while(i<n):

    if(permutare[i] in lista[stiva[-1]]):#daca exista muchie de la varful stivei la elementul curent din permutare o sa l adaug in stiva
        stiva.append(permutare[i])
        viz[permutare[i]]=1
        i=i+1
    elif AreVeciniNevizitati(lista[stiva[-1]],viz):#daca nu , verific daca elementul din vf stivei mai are vecini nevizitate , in caz afirativ inseamna ca nu s a respectat criteriul de parcurgere in adancime
        sem=0
        break
    else: #in caz ca nu are vecini nevizita => nu mai pot inainta=> elimin din stiva primul element
        stiva.pop()
        if(len(stiva)==0):#daca stiva este goala inseamna ca nu s au parcur toate nodurile=> nu e parcurgere valida
            sem=0
            break
print(sem)


#Complexitate:
#   -Prelucrarea datelor : O(n+m)
#   -Complexitate While : este similara cu cea de la parcurgerea DFS , diferenta fiind ca parcurg lista de vecin de doua ori
#                         =>  O(2*(n+m)) care apartine O(n+m) 
#   -Complexitate Totala : O(n+m).









