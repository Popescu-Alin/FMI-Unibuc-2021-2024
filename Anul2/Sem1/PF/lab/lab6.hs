
data Fruct = Mar String Bool | Portocala String Int
            deriving Show

listaFructe = [Mar "Ionatan" False, Portocala "Sanguinello" 10,Portocala "Valencia" 22,Mar "Golden Delicious" True,Portocala "Sanguinello" 15,Portocala "Moro" 12,Portocala "Tarocco" 3,Portocala "Moro" 12,Portocala "Valencia" 2,Mar "Golden Delicious" False]

--a
ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala nume feli) 
    |nume=="Moro"|| nume=="Tarocco" || nume=="Sanguinello" = True
    |otherwise=False
ePortocalaDeSicilia (Mar _ _) =False 
--b
nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia l= foldr (\(Portocala _ a) b -> b + a) 0 (filter ePortocalaDeSicilia l) 

--c
f :: Fruct->Bool
f (Portocala _ _) =False
f (Mar _ v)=v 
nrMereViermi :: [Fruct] -> Int
nrMereViermi l= length  (filter f l)

--2

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show

vorbeste :: Animal -> String
vorbeste (Pisica _ ) = "Meow"
vorbeste (Caine _ _) = "ham"


rasa :: Animal -> Maybe String
rasa (Pisica _) =Nothing
rasa (Caine _ rasa)= Just rasa 

--3
data Linie = L [Int]
    deriving Show
data Matrice = M [Linie]
    deriving Show

--a
verifica :: Matrice -> Int -> Bool
verifica (M m) nr = foldr (&&) True (map (\(L l) -> sum l == nr) m)

--b


