
def RezolvareA(n,listaMuchii):
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
        
        graf=citireGraf(listaMuchii,n)


        lvl=[0]*n
        upper=[0]*n
        tata=[0]*n
        critical=[False]*n
        rad=4
        
        def DFS(nod,nivel):
            lvl[nod]=nivel
            upper[nod]=nivel
            nrCopii=0
            for vecin in graf[nod]:
                if lvl[vecin]==0:
                    nrCopii+=1
                    tata[vecin]=nod
                    DFS(vecin,nivel+1)
                    upper[nod] = min(upper[nod],upper[vecin])

                    if upper[vecin] >= lvl[nod] and rad!=nod:
                        critical[nod]=True

                elif lvl[vecin]>0 and tata[nod]!=vecin:
                    upper[nod] = min(lvl[vecin],upper[nod])
                
            return nrCopii
        
        if DFS(rad,1)>1:
            critical[rad]=True
        

        for i in range(n):
            if critical[i]:
                print(i)



RezolvareA(5,[[1,0],[1,2],[2,0],[0,3],[3,4]])

