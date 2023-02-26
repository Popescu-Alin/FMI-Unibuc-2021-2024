
def CitireSiCreareMatrice():
    f = open("floyd_warshall.in",'r')
    n,m=[int(x) for x in f.readline().split()]
    FW=[[float('inf')]*(n+1) for x in range(n+1)]

    for i in range(n+1):
        FW[i][i]=0

    for _ in range(m):
        i,j,cost=[int(x) for x in f.readline().split()]
        FW[i][j]=cost

    return FW,n


FW,n=CitireSiCreareMatrice()


for k in range(1,n+1): # varfuri intermediare
    for i in range(1,n+1):
        for j in range(1,n+1):
            FW[i][j]=min(FW[i][j],FW[i][k]+FW[k][j])


for i in range(1,n+1):
    print(FW[i][1:])