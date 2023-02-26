


def RezolvareA():
        #prelucrez datele de intrare
        import heapq
        lista={}
        with open("catun.in",'r') as f:
            n,m,nr_cetati=[int(x) for x in f.readline().split()]
            for x in range(n+1):
                lista[x]=[]
            listaCetati=[int(x) for x in f.readline().split()]
            #Transform din vector de muchii in lista de adiacenta 
            for i in range(m):
                nod1,nod2,valoare=[int(x) for x in f.readline().split()]
                lista[nod1].append((nod2,valoare))
                lista[nod2].append((nod1,valoare))
            

        cetateApropiata=[-1]*(n+1)
        cetateApropiata[0]=0
        for cetate in listaCetati:
            cetateApropiata[cetate]=cetate
            lista[0].append((cetate,0))
            lista[cetate].append(((0,0)))
       
        grafL=lista
        viz=[False]*(n+1)
        tata=[None] * (n+1)
        d=[float('inf')] * (n+1)
        start=0
        d[start]=0
        tata[start]=-1
        heap=[(d[start],start)] #introduc doar nodul de start in heap (pt eficienta)sub forma de (valoare,nod)
        
        def relax(x,y,w):
            if d[y]==d[x]+w:
                if cetateApropiata[x]>0 and cetateApropiata[y]>0 and cetateApropiata[x]<cetateApropiata[y]:
                    cetateApropiata[y]=cetateApropiata[x]
            if d[y]>d[x]+w:
                d[y]=d[x]+w
                if cetateApropiata[x]!=0:
                    cetateApropiata[y]=cetateApropiata[x]
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
           
        
        for i in range(1,n+1):
            if cetateApropiata[i]==i or cetateApropiata[i]==-1:
                print(0,end=" ")
            else:
                print(cetateApropiata[i],end=" ")

        
        for i in range(1,n+1):
            if  cetateApropiata[i]==i and cetateApropiata.count(i)==1 :
                print(i)
        




RezolvareA()

