
f = open("graf.in",'r')
def citireGraf(): 
            global n,m
            n,m=[int(x) for x in f.readline().split()]
            lista={}
            for x in range(0,n+1):
                lista[x]=[]
            

            for i in range(m):
                nod1,nod2=[int(x) for x in f.readline().split()]
                lista[nod1].append(nod2)
                lista[nod2].append(nod1)
            
            k=int(f.readline())
            return lista,k


def Critical(graf,x):
        lvl=[0]*n
        upper=[0]*n
        tata=[0]*n
        critical=[]
        rad=x
        #folosim algoritmul prezentat in laborator
        #folosim DFS si determinam pt fiecare nod tatal sau , nivelul pe care se afla si 
        #nivelul la care se poate intoarce coborand in subarbore si folosind muchii de intoarcere.
        def DFS(nod,nivel):
            lvl[nod]=nivel
            upper[nod]=nivel
            for vecin in graf[nod]:
                if lvl[vecin]==0:
                    tata[vecin]=nod
                    DFS(vecin,nivel+1)
                    upper[nod] = min(upper[nod],upper[vecin]) #determin nivelul la care se poate intoarce, o data iesit din dfs un nod nu isi mai poate actualiza nivelul
                    if upper[vecin] > lvl[nod] :        
                        critical.append((nod,vecin))
                elif lvl[vecin]>0 and tata[nod]!=vecin:
                    upper[nod] = min(lvl[vecin],upper[nod])
                
        
        DFS(rad,1)
        return critical

def DFS(nod,comp):
    global graf
    viz[nod]=comp
    for vecin in graf[nod]:
        if viz[vecin]==0:
            DFS(vecin,comp)
            
        


graf,k=citireGraf()
n=len(graf)
viz=[0]*(n)
nr_comp=0

for rad in range(1,n):
      if viz[rad]==0:
        nr_comp+=1
        DFS(rad,nr_comp)

# in vizitat vom avea salvate componentele conexe.

rad=[]
crit=[]
for i in range(1,n):
     if viz[i] not in rad:
        crit.extend(Critical(graf,i))
        rad.append(viz[i])

#in acest moment avem o lista cu muchiile critice , nr de componente conexe si componentele conexe.

#idee
#ne plimbam prin muchii, daca gasim o muchie care nu e critica si are gradul ambelor noduri >2 atunci aceasta poate fi stearsa


sol=[]

rad=[]
for i in range(n):
    for j in graf[i]:
        if ( i,j) not in crit and len(graf[i])>=2 and len(graf[j])>=2 and nr_comp!=k:
                graf[i].remove(j)
                graf[j].remove(i)
                for t in range(1,n):
                    if viz[t]!=1 and viz[t] not in rad:
                        sol.append(f"({i},{j}) => (1,{t})")
                        nr_comp-=1
                        rad.append(viz[t])
                        break

print(graf)

if(nr_comp!=k):
    print("nu se poate")
else:                   
    print(f"minim {len(sol)} mutari cut-paste")
    for x in sol:
         print(x)




#complexitate:  Determinarea comp conexe= O(n+m)
#               Determinarea muchiilor critice O(n+m)
#               Parcurgerea si determianrea solutiei O(n+m)
#               Total = O(n+m)