
from logging import CRITICAL


def RezolvareA(n,connections):
        #prelucrez datele de intrare
        def citireGraf(li,n):
            lista={}
            for x in range(n):
                lista[x]=[]
            #Transform din vector de muchii in lista de adiacenta
            for muchie in li:
                nod1,nod2=[int(x) for x in muchie]
                lista[nod1].append(nod2)
                lista[nod2].append(nod1)
            
            return lista
        
        graf=citireGraf(connections,n)


        lvl=[0]*n
        upper=[0]*n
        tata=[0]*n
        critical=[]
        rad=0
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



print(RezolvareA(5,[[1,0],[2,0],[3,2],[4,2],[4,3],[3,0],[4,0]]
))

