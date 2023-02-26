



def RezolvareA(n, edges, succProb, start, end):
        #prelucrez datele de intrare
        
        import heapq

        def citireGraf(li,cost,n):
            lista={}
            for x in range(n):
                lista[x]=[]
            #Transform din vector de muchii in lista de adiacenta 
            for i in range(len(li)):
                valoare=cost[i]
                nod1,nod2=[int(x) for x in li[i]] #memorat sub forma de (valoare,nod)
                lista[nod1].append((valoare,nod2))
                lista[nod2].append((valoare,nod1))
            return lista
        
        
        
        grafL=citireGraf(edges,succProb,n)
        viz=[False]*n
        tata=[None] * n
        d=[float('inf')] * n
        d[start]=0
        tata[start]=-1
        heap=[(d[start],start)] #introduc doar nodul de start in heap pt eficienta

        while heap:
            dist,nod=heapq.heappop(heap) 
           
            if viz[nod]==False:
                for cost,vecin in grafL[nod]:
                    if d[vecin]>cost+d[nod]:
                        d[vecin]=cost+d[nod]
                        tata[vecin]=nod
                        heapq.heappush(heap,(d[vecin],vecin))
                viz[nod]=True
        
        return(tata,d)



print(RezolvareA(3,
[[0,1],[1,2],[0,2]],
[0.5,0.5,0.2],
0,
2))



