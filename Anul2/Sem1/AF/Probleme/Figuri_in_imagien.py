

import collections
def RezolvareA(grid):
        n=len(grid)
        m=len(grid[0])
        #mi am luat 2 vectori de mutari posibile
        miscareI=[0,1,-1,0]
        miscareJ=[1,0,0,-1]
        #incep parcurgerea pordind de la algoritmul BFS
        def BFS(CoordonataStart):
            grid[CoordonataStart[0]][CoordonataStart[1]]=-1
            dimensiune=0
            coada=collections.deque()
            coada.append(CoordonataStart)
            while coada:
                dimensiune+=1
                x,y=[x for x in coada.popleft()]
                
                for miscare in range(4):
                    i=x+miscareI[miscare]
                    j=y+miscareJ[miscare]
                    if 0<=i<n and 0<=j<m and grid[i][j]==1 : #adaug in coada fiecare punct din matrice adiacent cu punctu curent in care gasesc val 1
                        grid[i][j]=-1
                        coada.append((i,j))
            return dimensiune

        maxim=0
        for i in range(n):
            for j in range(m):
                if grid[i][j]==1: #aplic alg pt fiecare punct gasit
                    maxim = max(maxim, BFS((i,j)))

        return maxim




print(RezolvareA([[0,0,1,0,0,0,0,1,0,0,0,0,0],
                  [0,0,0,0,0,0,0,1,1,1,0,0,0],
                  [0,1,1,0,1,0,0,0,0,0,0,0,0],
                  [0,1,0,0,1,1,0,0,1,0,1,0,0],
                  [0,1,0,0,1,1,0,0,1,1,1,0,0],
                  [0,0,0,0,0,0,0,0,0,0,1,0,0],
                  [0,0,0,0,0,0,0,1,1,1,0,0,0],
                  [0,0,0,0,0,0,0,1,1,0,0,0,0]]))

