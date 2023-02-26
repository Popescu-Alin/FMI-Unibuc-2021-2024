import Data.Char
--1
pal :: String->Bool
pal string= string==reverse string
    

countV :: String->Int
countV[]=0
countV (s:l)
    |s `elem` "aeiouAEIOU" = 1 + countV l      
    |otherwise=countV l 

nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale (s:l) 
    |pal s =countV s +nrVocale l
    |otherwise=nrVocale l

--2
f:: Int-> [Int]->[Int]

f a []=[]

f a (h:t)
    |even h = h : a : (f a t)
    |otherwise= h :( f a t)

--3
divizori :: Int -> [Int]
divizori n = [ d | d <- [1..n], n`mod` d==0 ]

--4
listadiv :: [Int] -> [[Int]]

listadiv a = map divizori a

--5

inIntervalRec :: Int->Int->[Int]->[Int]

inIntervalRec a b []=[]

inIntervalRec a b (h:t)
    |(a<=h && h<=b) = h:inIntervalRec a b t
    |otherwise = inIntervalRec a b t


inIntervalComp :: Int->Int->[Int]->[Int]

inIntervalComp a b c = [d | d<-c, a<=d && d<=b]

--6
pozRec :: [Int]->Int

pozRec []=0
pozRec (h:t)
    |h>0 = 1+ pozRec t
    |otherwise = pozRec t

pozComp :: [Int]->Int
pozComp a = length  [d| d<-a , d>0]

--7
pozImpRecAux :: [Int]->Int->[Int]

pozImpRecAux [] _ = []

pozImpRecAux (h:t) n
    |even h ==False = n : pozImpRecAux t (n+1)
    |otherwise= pozImpRecAux t (n+1)


--far zip
-- pozImpComp :: [Int]->[Int]
-- pozImpComp a = [d|d <- [0..(length a)-1], even  (a !! d) ==False]

--cu zip
pozImpComp :: [Int]->[Int]
pozImpComp a = [p|(x,p) <- zip a [0..], even (x) ==False]

--8

multDigitsRec :: String->Int
multDigitsRec []= 1 
multDigitsRec (h:t)
    | isDigit h  = digitToInt h *   multDigitsRec t
    | otherwise = multDigitsRec t


multDigitsComp :: String->Int

multDigitsComp l= product [digitToInt d|d<-l, isDigit d  ]
