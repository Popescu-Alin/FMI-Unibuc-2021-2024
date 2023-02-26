import collections

f = open("easygraph.in",'r')
def RezolvareA():
        #prelucrez datele de intrare
        global n,val
        def citireGraf():
            global n,val
            n,m=[int(x) for x in f.readline().split()]
            lista={}
            val=[0]
            val.extend([int(x) for x in f.readline().split()])
            for x in range(0,n+1):
                lista[x]=[]
            
            for i in range(m):
                nod1,nod2=[int(x) for x in f.readline().split()]
                lista[nod1].append(nod2)
            
            return lista

        graf=citireGraf()
        viz=[0]*(n+1)
        suma=[float('-inf')]*(n+1)

        def TS(start):
            viz[start]=1
            suma[start]=max(suma[start],val[start]) # suma[start] se face maximul dintre valoarea nodului si suam[start]
                                                    # daca am in suma o valoare mai mica decat cea pe care as obtineo doar prin adaugarea nodului=> ca nu e suma maxima
                                                    #stim valorile nodurilor care au grad extern 0, adica nodurile de la finalul sortarii topologice.
                                                    #aceasta fiind chai valoarea nodului=> suma[nodFinal]=val[nodFinal]
            
            for x in graf[start]:
                if(viz[x]==0):
                    TS(x)
                suma[start]=max(suma[start],suma[x]+val[start]) #calculam suma in mod recursiv de la final spre inceput.Suma pe care pot sa o obtin la nodul anterior(x) este fixata si nu mai poate fi modificata
              
        rezultat=float('-inf')

        for x in range(1,n+1):
            if viz[x]==0:
                TS(x)
            if suma[x]>rezultat:
                rezultat=suma[x]

        return rezultat
        

            
T=int(f.readline())

for i in range(T):
    print (RezolvareA())

