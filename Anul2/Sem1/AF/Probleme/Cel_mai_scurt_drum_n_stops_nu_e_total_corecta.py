
def RezolvareA( n, flights, src, dst, k):
        import queue
        def citireGraf(li,n):
            lista={}
            for x in range(n):
                lista[x]=[]
            #Transform din vector de muchii in lista de adiacenta 
            for nod1,nod2,valoare in li:
                lista[nod1].append((valoare,nod2))
            return lista

        grafL=citireGraf(flights,n)
        viz=[False]*n
        tata=[None] * n
        d=[float('inf')] * n
        d[src]=0
        tata[src]=-1
            

        Q = queue.Queue()
        Q.put((0,src)) # in coada vom introduce elemete de tipul (cost,nod)

        stops=0# cate opriri a facut avionu (i.e. cate noduri a vizitat)
        while Q and stops<k+1:
            # vom folosii ideea de la BFS.Pentru fiecare nod din coada la intrareea in primul while
            # vom vizita toti vecinii sai, vom face update folosind relaxaea.
            noduriPeNivelulActual=Q.qsize()
            while noduriPeNivelulActual!=0:
                dist,nod=Q.get()
                for vecin in grafL[nod]:
                    if viz[nod]==False:
                        for cost,vecin in grafL[nod]:
                            if d[vecin]>cost+d[nod]:
                                d[vecin]=cost+d[nod]
                                tata[vecin]=nod
                                Q.put((d[vecin],vecin))
                
                noduriPeNivelulActual-=1
                    
            stops+=1
            
           
        
        if d[dst]==float('inf'):
            return -1
        
        return d[dst]
            

print(RezolvareA(4,
[[0,1,1],[0,2,5],[1,2,1],[2,3,1]],
0,
3,
1))