
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


    fin =open("cuplaj.in")
    
    #capacitatea maxima
    c_max=1 #stim ca fiecare muchie are capacitatea 1 asa ca capacitatea maxima este 1
    
    n,m,e=[int(x) for x in fin.readline().split()]
    #n= cardinalul primei multimi
    #m cardinalul celei de a doua
    final=n+m+1 #nodul de final f
    tata=[0]*(final+1)
    viz=[0]*(final+1)

    f=[[0 for i in range(final+1)] for j in range(final+1)]
    cost=[[0 for i in range(final+1)] for j in range(final+1)]

    #lista de adiacenta/nodurile care ies din x
    la=[[] for i in range(final+1)]
    #lista de incidenta/nodurile care intra in x
    lin=[[] for i in range(final+1)]
    #citim lista de muchii si completam matricea de adiacenta 
    for _ in range(e):
        x,y=[int(x) for x in fin.readline().split()]
        y=y+n #adaug n la fiecare id din lista celei de a doua multimi 
        la[x].append(y)
        lin[y].append(x)  
        cost[x][y]=1
        f[x][y]=0
    
    #pun nodul de start ca fiind nodul 0 si unesc toate nodurile din prima multime de acesta
    for i in range(1,n+1):
        la[0].append(i)
        lin[i].append(0)
        cost[0][i]=1
        f[0][i]=0

    #unim toate nodurile din multimea a doua la final
    for j in range(1,m+1):
        i=j+n        
        la[i].append(final)
        lin[final].append(i)
        cost[i][final]=1
        f[i][final]=0

    fin.close()
    fmax=0

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
        


    #pentru a determina muchiile vom afisa indicii elementele care au valoarea in f pozitiva
    for i in range(1,final):
        for j in range(1,final):
            if f[i][j]>0:
                print(i,j-n)

RezolvareA()
       


