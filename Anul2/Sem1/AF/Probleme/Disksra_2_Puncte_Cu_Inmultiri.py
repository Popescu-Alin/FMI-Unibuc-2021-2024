
from logging import CRITICAL


def RezolvareA(n, edges, succProb, start, end):
        #prelucrez datele de intrare
        import math
        import heapq

        def citireGraf(li,cost,n):
            lista={}
            for x in range(n):
                lista[x]=[]
            #Transform din vector de muchii in lista de adiacenta 
            for i in range(len(li)):
                valoare=(-1)*math.log(cost[i],2)
                nod1,nod2=[int(x) for x in li[i]] #memorat sub forma de (nod,valoare)
                lista[nod1].append((nod2,valoare))
                lista[nod2].append((nod1,valoare))

            return lista
        
        
        
        grafL=citireGraf(edges,succProb,n)
        viz=[False]*n
        tata=[None] * n
        d=[float('inf')] * n
        d[start]=0
        tata[start]=-1
        heap=[(d[start],start)] #introduc doar nodul de start in heap (pt eficienta)sub forma de (valoare,nod)
        
        def relax(x,y,w):
            if d[y]>d[x]+w:
                d[y]=d[x]+w
                tata[y]=x
                return True
            return False

        while heap:
            nod=heapq.heappop(heap) 
           
            if viz[nod[1]]==False:
                for vecin in grafL[nod[1]]:
                    if relax(nod[1],vecin[0],vecin[1]): 
                        heapq.heappush(heap,(d[vecin[0]],vecin[0]))
                viz[nod[1]]=True
           
        
        
        return(2**(-d[end]))



print(RezolvareA(3,
[[0,1],[1,2],[0,2]],
[0.5,0.5,0.2],
0,
2))

