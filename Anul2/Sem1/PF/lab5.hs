-- 1
suma :: [Int]->Int
suma l = foldr (+) 0 (map (^2) l)

-- 2
verif :: [Bool] ->Bool
verif l = foldr (&&) True l

--3
-- allVerifies :: (Int -> Bool) -> [Int] -> Bool
-- allVerifies f l = foldr (&&) True ((map f l))
-- sau
allVerifies :: (Int -> Bool) -> [Int] -> Bool
allVerifies f l = foldr (\ x acc-> f x && acc) True l


--4
anyVerifies :: (Int -> Bool) -> [Int] -> Bool
anyVerifies f l = foldr (||) False ((map f l))

--5
mapFoldr :: (Int->Int) ->[Int] ->[Int]
mapFoldr f l = foldr (\int acc -> (f int ):acc) [] l 

filterFoldr :: (Int->Bool) ->[Int] ->[Int]
filterFoldr f l = foldr (\int acc -> if f int then int:acc else acc ) [] l 


--6
f :: Integer->Integer->Integer
f e l  = l + e * 10

listToInt :: [Integer] -> Integer
listToInt l  = foldl f 0 l 

--7
--a
rmChar :: Char -> String -> String
rmChar c str = foldr (\ char acc -> if char==c then acc else char:acc  ) [] str

--b
rmCharsRec :: String -> String -> String
rmCharsRec l []=[]
rmCharsRec [] l=l
rmCharsRec (h:t) l = rmCharsRec t ls
        where ls= rmChar h l
 
--c 

rmCharsFold :: String -> String -> String
rmCharsFold l1 l2 = foldr (\char acc ->if elem char l1 then acc else char:acc  ) [] l2 
                                