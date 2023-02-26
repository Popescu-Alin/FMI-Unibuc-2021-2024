
import collections

def RezolvareA():
    
    def citireGraf():
        fin = open('maxflow.in')
        n,m=[int(x) for x in fin.readline().split()]
        # indexat de la 1
        n=n+1 

        graf=[[0]*n for x in range(n)]

        for i in range(m):
            nod1,nod2,cap = [int(x) for x in fin.readline().split()]
            graf[nod1][nod2]=cap

        fin.close();     
        return graf,n
    

    def BFS(n,graf,st,fin):
        viz=[False]*n
        coada = collections.deque()
        viz[st]=True
        coada.append(st)
        tata=[None]*n

        while coada:
            u= coada.popleft()

            for nod, val in enumerate(graf[u]):
                if viz[nod] == False and val > 0:
                    coada.append(nod)
                    viz[nod] = True
                    tata[nod] = u
        
        return (True,tata) if viz[fin] else (False,[])

    def FordFulkerson(n,graf,s,t):
    
        max_flow = 0

        while True:
            sem,tata = BFS(n,graf,s,t)
            if sem==False :
                break

            path_flow = float("Inf")
            cs = t
            while cs != s:
                path_flow = min(path_flow, graf[tata[cs]][cs])
                cs = tata[cs]

            max_flow += path_flow

            v = t
            while v != s:
                u = tata[v]
                graf[u][v] -= path_flow #arc direct
                graf[v][u] += path_flow #arc invers
                v = tata[v]

        return max_flow
    G,n=citireGraf()
    
    print(FordFulkerson(n,G,1,n-1));   
   

# consideram ca nodul 1 e sursa iar n e destinatia
RezolvareA()






