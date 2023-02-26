
def find(x):
    if tata[x]!=0 :
        tata[x]=find(tata[x])
        return tata[x]
    return x

def union(x,y):
    r1=find(x)
    r2=find(y)
    if h[r1]>h[r2]:
        tata[r2]=r1
    elif h[r2]>h[r1]:
        tata[r1]=r2
    else:
        tata[r2]=r1
        h[r1]+=1


with open("date.in",'r') as f, open("date.out",'w') as g:
    n,m=[int(x) for x in f.readline().split()] 
    tata=[0] * (n+1) #consider ca tatal unui nod este 0,(niciun nod nu are descendenti)
    h=[0]*(n+1)#inaltimea fiecarui subarbore e 0
    for i in range(m):
        op,nod1,nod2=[int(x) for x in f.readline().split()]
        if op==2:
            if find(nod1)==find(nod2):
                g.write("DA\n")
            else:
                g.write("NU\n")
        if op==1:
            union(nod1,nod2)
            
