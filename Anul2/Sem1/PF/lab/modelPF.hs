import System.Win32 (COORD(xPos))
--                                       Subiectul 1
-- Se dau următoarele:
-- Un tip de date ce reprezinta puncte cu numar variabil de coordonate intregi:
data Point = Pt [Int]
    deriving Show
-- Un tip de date ce reprezinta arbori binari de cautare (cu nodurile sortate):
data Arb = Empty | Node Int Arb Arb
    deriving Show
-- O clasă de tipuri ToFromArb
class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a
-- Sa se faca o instanta a clasei ToFromArb pentru tipul Point. 
-- Inserarea in arbore se va face tinand
-- cont de proprietatea arborelui de a fi sortat.

addToArb :: Int->Arb->Arb

addToArb x Empty = Node x Empty Empty
addToArb x (Node y l r)  = if x<y then Node y (addToArb x l) r else Node y (addToArb x r) l

addToPoint :: Arb-> [Int]
addToPoint Empty = []
addToPoint (Node v l r)=   [v] ++(addToPoint l) ++ (addToPoint r)


instance ToFromArb Point where
    -- toArb (Pt []) = Empty 
    -- toArb (Pt (x:xxs)) = Node x  Empty (toArb (Pt xxs))   
    toArb (Pt list) = foldr addToArb Empty (reverse list)
    fromArb arb = Pt $ addToPoint arb
list = Pt[1,2,3]


--                                          var 2


-- data Point = Pt [Int]
--   deriving Show

-- data Arb = Empty | Node Int Arb Arb
--   deriving Show

-- class ToFromArb a where
--   toArb :: a -> Arb
--   fromArb :: Arb -> a 

-- instance ToFromArb Point where 
--   toArb (Pt []) = Empty 
--   toArb (Pt (x:xs)) = Node x (toArb (Pt (filter (< x) xs)))  (toArb (Pt (filter (>= x) xs)))
--   fromArb Empty = Pt [] 
--   fromArb (Node x st dr) = let Pt l1 = fromArb st 
--                                Pt l2 = fromArb dr
--                            in Pt (l1 ++ [x] ++ l2)




--                                            Subiectul 2
-- Sa se scrie o functie care primeste doua numere intregi si o lista de numere intregi si construieste din
-- lista initiala, lista numerelor aflate in intervalul definit de cele doua numere. Sa se rezolve problema in
-- doua moduri (o solutie fara monade si o solutie cu monade).

--recursiv
getFromInterval :: Int -> Int -> [Int] -> [Int]
getFromInterval x y [] = []
getFromInterval x y (l:ls) 
    | l>=x && l<=y = l : getFromInterval x y ls
    | otherwise = getFromInterval x y ls   

--monade 
-- prod2 f xs ys = do 
--     x <- xs
--     y <- ys
--     return $ f x y


getFromInterval1 :: Ord b => b -> b -> [b] -> [b]
getFromInterval1 xs ys list = do 
    l <- list
    if (l >=xs && l<=ys)then return l else []

-- getFromInterval 5 7 [1..10] == [5,6,7]

--                                           var 2

-- -- cu selectie 
-- getFromIntervalSel a b list = [x | x<-list, x>=a, x<=b]
-- -- monade
-- getFromInterval a b list = do 
--     x<-list 
--     if a <= x && x <= b then return x else []


--                                        Subiectul 3
-- Se da tipul de date
newtype ReaderWriter env a = RW {getRW :: env-> (a,String)}
-- Sa se scrie instanta completa a clasei Monad pentru tipul ReaderWriter, 
-- astfel incat sa pastreze
-- proprietatea de monada, env fiind o memorie nemodificabila si 
-- concatenand toate stringurile. Nu este
-- nevoie sa faceti instante si pentru clasele Applicative si Functor.

instance Monad (ReaderWriter env) where
  return va = RW (\_ -> (va,""))
  ma >>= k = RW f 
      where f env = let (va, str1) = getRW ma env
                        (vb, str2)  = getRW (k va) env
                    in (vb, str1 ++ str2)

instance Applicative (ReaderWriter env) where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)       

instance Functor (ReaderWriter env) where              
  fmap f ma = pure f <*> ma



-- MONADA READER
-- newtype Reader env a = Reader { runReader :: env -> a }


-- instance Monad (Reader env) where
--   return x = Reader (\ _ -> x)
--   ma >>= k = Reader f
--     where f env = let a = runReader ma env
--                   in  runReader (k a) env



-- instance Applicative (Reader env) where
--   pure = return
--   mf <*> ma = do
--     f <- mf
--     a <- ma
--     return (f a)       

-- instance Functor (Reader env) where              
--   fmap f ma = pure f <*> ma 


-- --- Monada Writer

-- newtype WriterS a = Writer { runWriter :: (a, String) } 


-- instance  Monad WriterS where
--   return va = Writer (va, "")
--   ma >>= k = let (va, log1) = runWriter ma
--                  (vb, log2) = runWriter (k va)
--              in  Writer (vb, log1 ++ log2)


-- instance  Applicative WriterS where
--   pure = return
--   mf <*> ma = do
--     f <- mf
--     a <- ma
--     return (f a)       

-- instance  Functor WriterS where              
--   fmap f ma = pure f <*> ma  