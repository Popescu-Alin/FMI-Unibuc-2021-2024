
def RezolvareA():
    from collections import deque
    #functia de detereminare a lanturilor nesaturate
    def bf(s, n,la,lin, f,  cost, tata, viz):
        for i in range(n+1):
            viz[i]=tata[i]=0
        
        c=deque()
        
        c.append(s)
        viz[s]=1
        while(len(c)>0):
            x=c.popleft()
            for y in la[x]:
                                                            
                if viz[y]==0 and f[x][y]<cost[x][y]:
                    tata[y]=x
                    if y==n:
                        return 1
                    c.append(y)
                    viz[y]=1
    
            for y in lin[x]:                                              
                if viz[y]==0 and f[y][x]>0:
                    tata[y]=-x
                    if y==n:
                        return 1
                    c.append(y)
                    viz[y]=1

        return 0      


    fin =open("harta.in")
    
    #capacitatea maxima
    c_max=0 #stim ca fiecare muchie are capacitatea 1 asa ca capacitatea maxima este 1
    NrMuchii=0
    n=int(fin.readline())
    m=n
    #n cate noduri am
    final=n+m+1 #nodul de final f
    tata=[0]*(final+1)
    viz=[0]*(final+1)

    f=[[0 for i in range(final+1)] for j in range(final+1)]
    cost=[[0 for i in range(final+1)] for j in range(final+1)]

    #lista de adiacenta/nodurile care ies din x
    la=[[] for i in range(final+1)]
    #lista de incidenta/nodurile care intra in x
    lin=[[] for i in range(final+1)]
    
    #facem o bipartitie a nodurilor n intro partitie n in alta le vom uni 2 cate 2 a i i!=j si i apare in prima partitie j in a doua
    #le unim cu un nod de start 0 si cu unul de final n+n+1
    # prima partitie este unita cu s si are fluxurile pemuchie determinat degrduul de iesire
    # analog pt cea de a doua 
    
    #citim lista de grade 

    for i in range(1,n+1):
        x,y=[int(x) for x in fin.readline().split()]
        #adaug pt nodul i la lista sa de adiacenta nodul 0
        #pt nodul 0 adaug elementu i
        la[0].append(i)
        lin[i].append(0)
        #adaug ca si flux pt i valoarea x
        cost[0][i]=x
        f[0][i]=0

        #adaug pt nodul i (din a doua partitie i.e. i+n)
        j=i+n        
        la[j].append(final)
        lin[final].append(j)
          #adaug ca si flux pt i valoarea y
        cost[j][final]=y
        f[j][final]=0
        NrMuchii+=x
        c_max=max(c_max,x,y)
        
    fin.close()
    fmax=0
    #unesc cele 2 partiti
    for i in range(1,n+1):
        for j in range(1,n+1):
            if i!=j:
                cost[i][n+j]=1
                la[i].append(j+n)
                lin[j+n].append(i)
    
    
    

    s=0 #sursa
    t=final #destinatia
    
    while bf(s,final,la,lin,f,cost,tata,viz): 
       
        #calculam i(P) = capacitatea reziduala minima pe un arc de pe drumul de la s la t determinat cu bf   
        iP=c_max #i(P)
        t=final
        while t!=s:
            if tata[t]>=0: #arc direct - capacitate c(e)-f(e)
                if cost[tata[t]][t]-f[tata[t]][t]<iP:
                    iP= cost[tata[t]][t]-f[tata[t]][t]  
                t=tata[t]     
            
            else: #arc invers - capacitate f(e) 
                if  f[t][-tata[t]]<iP:
                    iP= f[t][-tata[t]]
                t=-tata[t]
            
             
        #revizuim fluxul de-a lungul lantului determinat 
        t=final
        while t!=s:
            if tata[t]>=0 : #arc direct - creste fluxul cu iP
                f[tata[t]][t]+=iP 
                t=tata[t]
            
            else: #arc invers - scade fluxul cu iP
                f[t][-tata[t]]-=iP
                t=-tata[t]
            
                    
        fmax+=iP #creste valoarea fluxului cu iP
        
    print(fmax)

    
    if fmax==NrMuchii:
        #pentru a determina muchiile vom afisa indicii elementele care au valoarea in f pozitiva
        for i in range(1,final):
            for j in range(1,final):
                if f[i][j]==1:
                    print(i,j-n)
    else:
        print("NU SE POATE");
RezolvareA()
       


