


def RezolvareA(n):
         #prelucrez datele de intrare
        import heapq

        # def citireGraf(li,cost,n):
        #     lista={}
        #     for x in range(n):
        #         lista[x]=[]
        #     #Transform din vector de muchii in lista de adiacenta 
        #     for i in range(len(li)):
        #         valoare=cost[i]
        #         nod1,nod2=[int(x) for x in li[i]]   #memoram in lista de adiaceta valoei :(cost, nod) 
        #         lista[nod1].append((valoare,nod2))
        #         lista[nod2].append((valoare,nod1))

        #     return lista
        
        
        
        grafL={ 1:[(28,2),(10,6)],
                2:[(28,1),(16,3),(14,7)],
                3:[(16,2), (12,4)],
                4:[(12,3),(22,5),(18,7)],
                5:[(22,4),(24,7),(25,6)],
                6:[(10,1),(25,5)],
                7:[(14,2),(18,4),(24,5),]
              }
        start=1

        viz=[False]*(n+1)
        viz[0]=True # nu am nod 0 in aces caz
        tata=[None] * (n+1)
        d=[float('inf')] * (n+1)
        d[start]=0
        tata[start]=-1
        heap=[(d[start],start)]  #am intordus toate elementele sub forma de (cost, nod) ce reprezinta costul minim pana la nodul i
        heapq.heapify(heap) 

        while heap:
            nod=heapq.heappop(heap) 
           
            if viz[nod[1]]==False:
                for vecin in grafL[nod[1]]:
                    if d[vecin[1]]>vecin[0]:
                        d[vecin[1]]=vecin[0]
                        tata[vecin[1]]=nod[1]
                        heapq.heappush(heap,(d[vecin[1]],vecin[1]))
                viz[nod[1]]=True
           
        return(tata)



        




print(RezolvareA(7))

