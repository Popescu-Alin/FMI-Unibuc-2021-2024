
# algoritmul foloseste o matice de len(text1)*len(text2)=> complecitate O(len(text1)*len(text2))
def RezolvareA(text1,text2):
    l1=len(text1)+1
    l2=len(text2)+1

    LCS=[[0]*l2 for _ in range(l1)]
    
    #elementele de pe colana 0 si linia 0 sunt 0
    #vom completa matricea incepand cu elementul LCS[1][1]
    #Rezultatul va fi stocat pe pozitia LCS[l1-1][l2-1]
    for i in range(1,l1):
        for j in range(1,l2):
            #daca elementul de pe pozitia i este egal cu cel de pe pozitia j vom adauga 
            #1 la elemetul de pe pozitai LCS[i-1][j-1] 
            if text1[i-1]==text2[j-1]:
                LCS[i][j]=1+LCS[i-1][j-1]
            #altfel vom face maximul dintreLCS[i-1][j] si LCS[i][j-1]
            else:
                LCS[i][j]=max(LCS[i-1][j],LCS[i][j-1])
    return LCS[l1-1][l2-1]

print(RezolvareA("abcde",  "ace"))


# algoritmul foloseste o matice de len(text1)*len(text2)=> complecitate O(len(text1)*len(text2))
def RezolvareB(sir1,sir2):
    
        def LCS_alg(text1,text2):
            l1=len(text1)+1
            l2=len(text2)+1

            LCS=[[0]*l2 for _ in range(l1)]
            #elementele de pe colana 0 si linia 0 sunt 0
            #vom completa matricea incepand cu elementul LCS[1][1]
            #Rezultatul va fi stocat pe pozitia LCS[l1-1][l2-1]
            for i in range(1,l1):
                for j in range(1,l2):
                    #daca elementul de pe pozitia i este egal cu cel de pe pozitia j vom adauga 
                    #1 la elemetul de pe pozitai LCS[i-1][j-1] 
                    if text1[i-1]==text2[j-1]:
                        LCS[i][j]=1+LCS[i-1][j-1]
                    #altfel vom face maximul dintreLCS[i-1][j] si LCS[i][j-1]
                    else:
                        LCS[i][j]=max(LCS[i-1][j],LCS[i][j-1])
            
            #formam stringul lcs astfel:
            #pornim de la final daca caracterele sunt egale il putem adauga
            #daca nu in fuctie de ce ramura am ales la pasus LCS[i][j] (i.e LCS[i-1][j] or LCS[i][j-1])
            #vom scadea indicele (i respectiv j)

            #pentru a crea stringul SCS vom modifica algoritmul de eterminare a LCS atfel
            #daca nu sunt egale caracterele vom adauga caracterul de pe pozitia i respectiv j
            #si apoi decrementam valoarea sa
            #iar la fina restul caracterelor
            lcs_string=[]
            i=l1-1
            j=l2-1
            while i>0 and j>0:

                if text1[i-1]==text2[j-1]:
                    lcs_string.append ( text1[i-1])
                    i=i-1
                    j=j-1

                elif LCS[i-1][j]>LCS[i][j-1]:
                    lcs_string.append(text1[i-1])
                    i=i-1
                else:
                    lcs_string.append(text2[j-1])
                    j=j-1
            
            while i>0:
                lcs_string.append(text1[i-1])
                i=i-1
        
            while j>0:
                lcs_string.append(text2[j-1])
                j=j-1

            return "".join(lcs_string)[::-1]
        
        return LCS_alg(sir1,sir2)

print(RezolvareB("abcde",  "ace"))
        


