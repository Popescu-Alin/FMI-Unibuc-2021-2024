--1
poly2:: Double->Double->Double->Double->Double
poly2 a b c x = a*x*x +b*x+c

--2
eeny :: Integer -> String
eeny x
    | even x = "eeny"
    | otherwise = "meeny"

--3
fizzbuzz :: Integer -> String
fizzbuzz x
    |x `mod` 15 == 0 = "FB"
    |mod x 3 == 0 = "Fiz"
    |mod x 5 == 0 = "Buzz"
    |otherwise= ""

--
fibo::Integer->Integer
fibo 0=0
fibo 1=1
fibo n=(fibo (n-1)) + (fibo(n-2)) 

--4
tribonacci :: Integer -> Integer
tribonacci n
    |n==1 =1
    |n==2 =1
    |n==3 =2
    |otherwise= tribonacci(n-1)+tribonacci(n-2)+ tribonacci(n-3)

--5
binomial:: Integer -> Integer->Integer

binomial n k
    |n==0 =0
    |k==1 =1
    |otherwise= (binomial(n-1) k) + (binomial(n-1) (k-1))

--liste
--6
verifL :: [Int] -> Bool
verifL list
    | even (length list) =True
    | otherwise=False

--7

--takefinal :: [Int] -> Int -> [Int]
takefinal list n
    | length list< n =list
    |otherwise = drop (length list -n) list

remove :: [Int] -> Int -> [Int]
remove list n 
    |length list < n =list
    |otherwise= ((take n list) ++ (drop (n+1) list))


--model recursivitate pe vectori...

semiPareRec :: [Int] -> [Int]
semiPareRec [] = []
semiPareRec (h:t)
    | even h = h `div` 2 : t'
    | otherwise = t'
    where t' = semiPareRec t

--7

myreplicate :: [Int] -> Int -> [Int]
myreplicate [] v  = []
myreplicate (h:t) v
    | h==v = h : t'
    | otherwise = t'
    where t' = myreplicate t v
--a
myreplicate2:: Int->Int->[Int]
myreplicate2 n v
    |n==0 =[]
    |n==1 =[v]
    |otherwise = v:(myreplicate2 (n-1) v)

--b
sumImp::[Int] -> Int
sumImp []=0
sumImp (h:t)
    | even h==False =t'+h
    |otherwise =t'
    where t'=sumImp t

--c 
totalLen :: [String] -> Int
totalLen []=0
totalLen  (h:t)
    |(h !! 0 =='A') = length h +t'
    |otherwise =t'
    where t'=totalLen t