import Data.Char 


--3
data Ingredient = Ing String Int
    deriving Show 
data Reteta = Li[Ingredient]
    deriving Show 
 
i1=Ing "FAina" 500
i2=Ing "Faina" 500
r1= Li [ Ing "Faina" 500, Ing "oua" 4, Ing "zahar" 500]
r2= Li [ Ing "FAina" 500, Ing "zahar" 500, Ing "oua" 4]
r3= Li [ Ing "FAina" 500, Ing "zahar" 500, Ing "oua" 55]


instance Eq Ingredient where
    (==) :: Ingredient -> Ingredient -> Bool
    Ing n c == Ing nume cantitate = c==cantitate && map toUpper n == map toUpper n

contains :: (Eq a) => [a] -> [a] -> Bool
contains [] l = True
contains (x:xs) l = x `elem` l && contains xs l  

instance Eq Reteta where
    (Li []) == (Li []) = True
    (Li x) ==(Li y) = contains x y && contains y x 


--6
functie :: String -> [String] -> String
functie s [] = []
functie s (x:xs) = if length(xs) == 0 then x ++ functie s xs else x ++ s ++ functie s xs

--11

divizori :: Int -> Int 
divizori n = sum[d | d <- [1..n], n `mod` d == 0]

fct :: [Int] -> Int -> Int -> [Int]
fct [] x y = []
fct (h:t) x y = if h >= x && h<=y then divizori h : fct t x y  else fct t x y 

--pr 


f1 :: String -> String
f1 "" = ""
f1 (x:xs) = if isDigit x then "*" ++ f1 xs else 
            if isUpper x then  (toLower x) : f1 xs else
                if isLower x then "#" ++ f1 xs else f1 xs

f :: [String] -> [String]
f [] = []
f (x:xs) = f1 x : f xs

-- pr 2
-- lungime :: [Int] -> Int 
-- lungime [] = 0
-- lungime (x:xs) = [a<-x | if length (a) `mod` 2 == 0 then a+lungime xs else lungime xs]

fct1 :: [Int] -> Int -> Int -> Bool
fct1 [] x y = True
fct1 (h:t) x y = if h >= x && h<=y then  True && fct1 t x y  else False

f3::[[Int]] ->Int->Int->Bool

f3 [] _ _ = True
f3 (h:t) x y 
    | fct1 h x y = even (length h) && f3 t x y
    |otherwise = f3 t x y