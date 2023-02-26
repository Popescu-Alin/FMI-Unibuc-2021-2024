import collections

f = open("graf.in",'r')

def citireGraf(): #memoram sub forma de lista de adiacenta, sub forma de tupluri (vecin ,cost/valoare)
            global n,val
            n,m=[int(x) for x in f.readline().split()]
            lista={}
            for x in range(0,n):
                lista[x]=[]
            val=[0]*n

            for i in range(m):
                nod1,nod2,cost=[int(x) for x in f.readline().split()]
                lista[nod1].append((nod2,cost))
            
            k=int(f.readline())
            return lista,k

def RezolvareA(graf):
        #prelucrez datele de intrare
        global n,viz

        def TS(start):
            viz[start]=1
            suma[start]=max(suma[start],val[start]) # suma[start] se face maximul dintre valoarea nodului si suam[start]
                                                    # daca am in suma o valoare mai mica decat cea pe care as obtineo doar prin adaugarea nodului=> ca nu e suma maxima
                                                    #stim valorile nodurilor care au grad extern 0, adica nodurile de la finalul sortarii topologice.
                                                    #aceasta fiind chai valoarea nodului=> suma[nodFinal]=val[nodFinal]
                                                    #val[nod] este mereu 0
            
            for x,cost in graf[start]:
                if(viz[x]==0):
                    TS(x)
                if cost<=k:
                    if suma[start]<suma[x]+cost:
                         tata[start]=x
                    suma[start]=max(suma[start],suma[x]+cost) #calculam suma in mod recursiv de la final spre inceput.Suma pe care pot sa o obtin la nodul anterior(x) este fixata si nu mai poate fi modificata


        rezultat=float('-inf')

        for x in range(0,n):
            if viz[x]==0:
                TS(x)
            if suma[x]>rezultat:
                rezultat=suma[x]

        return rezultat,tata,suma
        

graf,k=citireGraf()
n=len(graf)
viz=[0]*(n+1)
val=[0]*(n+1)
suma=[float('-inf')]*(n)
tata=[-1]*(n+1)
rezultat,tata,suma=RezolvareA(graf)

drum=[]
nod_strat=-1
for i in range(n): #determin nodul care are suma maxima 
     if suma[i]==rezultat: 
          nod_strat=i
          break

#deoarece am calulcat suma de la final spre inceput in vectorul de tati voi avea ca tata[x]=y chiar daca muchia era (y,x)=> in determina vom da append=> ordinea corecta.

while nod_strat!=-1 :
     drum.append(nod_strat)
     nod_strat=tata[nod_strat]

print("Drumul este:")
print(*drum)



#complexitate Algoritm : O(m) citirea, O(m+n) sortarea topologica+ determinarea sumei maxime cerute
#O(n) complexitatea determinarii drumuui.=> Complexuitate totala O(m+n)

