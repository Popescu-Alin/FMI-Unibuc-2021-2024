--1
factori :: Int -> [Int]
factori n = [d | d<-[1..n], n `mod` d == 0 ]

--2
prim :: Int -> Bool
prim n =  length  (factori n) ==2 

--3

numerePrime :: Int -> [Int]
numerePrime n = [d | d<-[2..n], prim d] 

--4

myzyp3:: [a]->[b]->[c]->[(a,b,c)]

myzyp3 l1 l2 l3 = [(a,b,c) |(a,(b,c))<-zip l1 (zip l2 l3)]

--5

firstEl:: [(a,b)]->[a]
firstEl l = map fst l

--6

sumList:: [[Int]]->[Int]
sumList l = map sum l

--7
prel2:: [Int]->[Int]
prel2 l = map (\a->if even a then  a `div` 2 else a*2 ) l


--8 
foo:: Char->[String]->[String]
foo c l = filter (elem c) l

--10

bar :: [Int]->[Int] 
--bar l = map (^2) [a |(a,d)<-zip l [0..] , odd d ]
bar l = map (\(a,b)->a^2) (filter (\(a,b)->odd b) (zip l [0..]))


--9
bar2 :: [Int]->[Int] 
bar2 l = map (^2) (filter odd l)

--11
foo2:: [String]->[String]
foo2 l = map (filter ( \e -> elem e "AEIOUaeiou" )) l

--12
mymap:: (a->b)->[a]->[b]
mymap f [] = []
mymap f (h:t) = f h : mymap f t 

myfilter :: (a -> Bool) -> [a] -> [a]
myfilter f [] =[]
myfilter f (h:t) 
    | f h = h : myfilter f t
    |otherwise = myfilter f t