



def RezolvareA(pairs):
        #problema se aseamana cu problema determinarii unui ciclu eulerian. 
        def citireGraf(li):
            lista={}
            GOut={} #determin gradul extern al unui nod
            GIn={} #determinngradul indern al unui nod
            #Transform din vector de muchii in lista de adiacenta 
            for i in range(len(li)):
                nod1,nod2=[int(x) for x in li[i]] 
                if nod1 not in GOut:
                    GOut[nod1]=0
                if nod2 not in GOut:
                    GOut[nod2]=0
                if nod2 not in GIn:
                    GIn[nod2]=0
                if nod1 not in GIn:
                    GIn[nod1]=0
                
                if nod1 not in lista:
                    lista[nod1]=[]
                if nod2 not in lista:
                    lista[nod2]=[]
                lista[nod1].append(nod2)
                GOut[nod1]=  GOut[nod1]+1
                GIn[nod2]=  GIn[nod2]+1
                
            return lista,GIn,GOut
        
        graf,GIn,GOut=citireGraf(pairs)
        #stim ca se poate obtine o ordonare => avem 2 variante 
        #1 exsita un nod care are gradul extern -gradul intern=1 =>incepem cu el
        #2 nu exista un astfel de not => putem incepe cu orice nod
        
        #verificam daca exista nod care sa indeplineasca  1 
        start=None
       
        for nod in GOut:
            if GOut[nod]-GIn[nod]==1:
                start=nod
        start = start if start!=None else list(GOut.keys())[0]

        #Stim ca exista o solutie valida =>putem face o parcurgere (asemanatoare cu dfs ) pentru a parcurge toate muchiile
       
        stiva=[start]
        sol=[]
        #cat timp stiva nu este vida 
        while stiva:
            #parcurgem lista de vecini a elemetului din vf stivei
            #si il introduc in stiva si il elimin din lista de vecini 
            # => elementul din varful stive devine vecinul sau
            #=> ma duc in adancime in parcurgere
            while  graf[stiva[-1]] :
                vf=graf[stiva[-1]].pop()
                stiva.append(vf)
            #la final adaug elemtul din vf stivei in solutie=>obtin nodurile in ordine inversa
            sol.append(stiva.pop())
        
        #obtin elementele in ordinea corecta
        sol.reverse()
        
        return [[sol[i-1],sol[i]] for i in range(1,len(sol))]
        
       



print(RezolvareA([[1,3],[3,2],[2,1]]))



