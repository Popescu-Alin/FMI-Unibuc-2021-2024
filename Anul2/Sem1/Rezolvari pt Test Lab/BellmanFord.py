


def RezolvareA( ):
        grafL={ 1:[(1,2,5),(1,3,7)],
                2:[(2,4,1)],
                3:[(3,2,-3)],
                4:[(4,5,-1),(4,3,3)],
                5:[]
              }
        n=5
        listaMuchii=[(1,2,5),(1,3,7),(2,4,1),(3,2,-3),(4,5,-1),(4,3,3)] #muchiile de tipu (nod1,nod2,cost)
        start=1
        tata=[None] * (n+1)
        d=[float('inf')] * (n+1)

        d[start]=0
        tata[start]=-1

        for k in range(1,n):
            for u,v,cost in listaMuchii:
                if d[u] +cost<d[v]:
                    d[v]=d[u]+cost
                    tata[v]=u
        print(d)

RezolvareA()