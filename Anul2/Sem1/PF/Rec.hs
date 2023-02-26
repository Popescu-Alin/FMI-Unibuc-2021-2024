

import System.Win32 (COORD(xPos), pAGE_EXECUTE)
import Distribution.Compat.CharParsing (digit)
import  Data.Char 

--                                    Laboratorul 6


data Fruct
    = Mar String Bool
    | Portocala String Int

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False,
                Portocala "Sanguinello" 10,
                Portocala "Valencia" 22,
                Mar "Golden Delicious" True,
                Portocala "Sanguinello" 15,
                Portocala "Moro" 12,
                Portocala "Tarocco" 3,
                Portocala "Moro" 12,
                Portocala "Valencia" 2,
                Mar "Golden Delicious" False,
                Mar "Golden" False,
                Mar "Golden" True]

--1
ePortocalaDeSicilia :: Fruct -> Bool

ePortocalaDeSicilia (Portocala str _) = if str=="Moro" || str=="Tarocco" || str=="Sanguinello" then True else False 
ePortocalaDeSicilia (Mar _ _)= False

--2
nrFelii :: Fruct -> Int
nrFelii (Portocala _ n) = n
nrFelii _ = 0

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia []=0
nrFeliiSicilia (h:t)
    |ePortocalaDeSicilia h = (nrFelii h) + nrFeliiSicilia t
    |otherwise = nrFeliiSicilia t

--3

eMarCuViermi :: Fruct -> Bool

eMarCuViermi (Mar str boolean) = if boolean==True then True else False 
eMarCuViermi (Portocala _ _)= False

nrMereViermi :: [Fruct] -> Int
nrMereViermi l = length (filter (eMarCuViermi) l) 
-- nrMereViermi []=0
-- nrMereViermi (h:t)
--     |eMarCuViermi h = 1+nrMereViermi t
--     |otherwise = nrMereViermi t

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show

--4
vorbeste :: Animal -> String
vorbeste (Pisica _)= "Meow!"
vorbeste (Caine _ _ ) = "Woof!" 

--5
rasa :: Animal -> Maybe String
rasa (Pisica _) = Nothing
rasa (Caine _ l ) =  Just l

--6
data Linie = L [Int]
    deriving Show
data Matrice = M [Linie]
    deriving Show

f:: Linie ->Int 
f (L l) =  sum l 

verifica :: Matrice -> Int -> Bool
verifica (M l) a = foldr(\x acc -> f x==a && acc) True l

--7
functie :: Linie -> Bool
functie (L [])=True
functie (L (x:xs)) 
   |x>0 = True && functie(L xs)
   |otherwise = False

doarPozN :: Matrice -> Int -> Bool
doarPozN (M l) a=  foldr(\x acc -> functie x && acc) True (filter (\(L x) -> length x==a) l)

--8
len:: [Linie]->Int

len (L(x):xs)=length x

corect :: Matrice -> Bool
corect (M lin)=  foldr(\(L x) acc -> length x==len(lin) && acc) True lin



--                                      Laboratorul 7

data Expr = Const Int -- integer constant
  | Expr :+: Expr -- addition
  | Expr :*: Expr -- multiplication
   deriving Eq

data Operation = Add | Mult deriving (Eq, Show)
data Tree = Lf Int -- leaf
   | Node Operation Tree Tree -- branch
   deriving (Eq, Show)

--1
instance Show Expr where
    show (Const a) = show a
    show (a :+: b) = show  a ++ "+" ++  show  b
    show ( a :*:  b) = show a ++ "*" ++ show b

--2
evalExp :: Expr -> Int
evalExp (Const a) = a 
evalExp (a :+:b) = evalExp(a) + evalExp(b)
evalExp (a:*:b) = evalExp(a) * evalExp(b)  


exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))

--3
evalArb :: Tree -> Int
evalArb (Lf a) = a
evalArb (Node Add a b) = evalArb a + evalArb b
evalArb (Node Mult a b) = evalArb a * evalArb b

arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))

--4
expToArb :: Expr -> Tree
expToArb (Const a) = Lf a
expToArb (a :+:b) = Node Add (expToArb a) (expToArb b)
expToArb (a:*:b) = Node Mult(expToArb a ) (expToArb b)



--                             Laboratorul 8

data Punct = Pt [Int]    
data Arb = Vid | F Int | N Arb Arb
    deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

--1 
showPt:: Punct ->String

showPt (Pt[]) ="" 
showPt (Pt(h:t))=if t/=[] then show h ++"," ++ showPt (Pt t) else show h

instance Show Punct where 
    show (Pt pct)= "(" ++ (showPt (Pt pct))++ ")"

--2
data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
    perimeter :: (Floating a) => g a -> a
    area :: (Floating a) => g a -> a

instance GeoOps Geo where
    perimeter (Square a) = 4*a
    perimeter (Rectangle a b)=2*(a+b)
    perimeter (Circle a) = pi*a*2

instance (Floating a, Eq a) => Eq (Geo a) where
    a==b = perimeter a==perimeter b

--lab 10

data Pair a = Pair a a
    deriving Show

instance Functor Pair where
    fmap :: (a -> b) -> Pair a -> Pair b 
    fmap f (Pair x b) = Pair (f x) (f b)

data Two a b = Two a b
instance Functor (Two a) where
    fmap :: (a2 -> b) -> Two a1 a2 -> Two a1 b
    fmap f (Two a b) = Two a (f b)

data Three a b c = Three a b c
instance Functor (Three a b) where 
    fmap :: (a2 -> b2) -> Three a1 b1 a2 -> Three a1 b1 b2
    fmap f (Three a b c) = Three a b(f c)

data Three' a b = Three' a b b
instance Functor (Three' a) where 
    fmap :: (a2 -> b) -> Three' a1 a2 -> Three' a1 b
    fmap f (Three' a b c) = Three' a (f b) (f c)

data Four a b c d = Four a b c d

instance Functor (Four a b c) where
    fmap :: (a2 -> b2) -> Four a1 b1 c a2 -> Four a1 b1 c b2
    fmap f (Four a b c d) = Four a b c (f d)

data Four'' a b = Four'' a a a b

instance Functor (Four'' a) where 
    fmap :: (a2 -> b) -> Four'' a1 a2 -> Four'' a1 b
    fmap f (Four'' a b c d) = Four'' a b c (f d)

data Quant a b = Finance | Desk a | Bloor b

instance Functor (Quant a) where 
    fmap f Finance = Finance
    fmap f (Desk a)=Desk a
    fmap f (Bloor b) =Bloor (f b)


data LiftItOut f a = LiftItOut (f a)
    deriving Show

instance Functor f => Functor (LiftItOut f) where
    fmap g (LiftItOut fa) =LiftItOut (fmap g fa) 


data Parappa f g a = DaWrappa (f a) (g a)
       deriving Show

instance (Functor f,Functor g) => Functor (Parappa f g) where
    fmap h (DaWrappa fa fg) =DaWrappa (fmap h fa) (fmap h fg)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
    deriving Show

instance (Functor f, Functor g) => Functor (IgnoreOne f g a) where
    fmap :: (Functor f, Functor g) =>(a1 -> b) -> IgnoreOne f g a a1 -> IgnoreOne f g a b
    fmap f (IgnoringSomething fa gb) = IgnoringSomething fa (fmap f gb)


data Notorious g o a t = Notorious (g o) (g a) (g t)
    deriving Show
instance Functor g => Functor (Notorious g o a ) where
    fmap :: Functor g => (a1 -> b) -> Notorious g o a a1 -> Notorious g o a b
    fmap h (Notorious go ga gt) = Notorious go ga (fmap h gt)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
    deriving Show

instance Functor GoatLord where
    fmap _ NoGoat= NoGoat
    fmap f (OneGoat a)= OneGoat (f a)
    fmap f (MoreGoats a b c)= MoreGoats (fmap f a) (fmap f b) (fmap f c)
    

data TalkToMe a = Halt | Print String a | Read (String -> a)

instance Functor TalkToMe where
    fmap _ Halt=Halt
    fmap f (Print a b)= Print a (f b)
    fmap f (Read g) = Read (f.g)



--                        LABORATOR 11
{-
class Functor f where
fmap :: (a -> b) -> f a -> f b
class Functor f => Applicative f where
pure :: a -> f a
(<*>) :: f (a -> b) -> f a -> f b
Just length <*> Just "world"
Just (++" world") <*> Just "hello,"
pure (+) <*> Just 3 <*> Just 5
pure (+) <*> Just 3 <*> Nothing
(++) <$> ["ha","heh"] <*> ["?","!"]
-}


data List a = Nil
            | Cons a (List a)
        deriving (Eq, Show)

instance Functor List where
        fmap f Nil = Nil 
        fmap f (Cons x xs) =Cons (f x) (fmap f xs)

instance Applicative List where
        pure x = Cons x Nil 
        Nil <*> _ = Nil
        Cons f listF <*> listElem = lappend (fmap f listElem)  (listF <*> listElem) 
                                    where 
                                        lappend Nil list = list
                                        lappend (Cons a list1)  list2 = Cons a (lappend list1 list2)


ff = Cons (+1) (Cons (*2) Nil)
v = Cons 1 (Cons 2 Nil)
test1 = (ff <*> v) == Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil)))

--2
data Cow = Cow {
    name :: String
    , age :: Int
    , weight :: Int
    } deriving (Eq, Show)

--a)
noEmpty :: String -> Maybe String
noEmpty ""= Nothing
noEmpty s = Just s
 
noNegative :: Int -> Maybe Int
noNegative n = if n<0 then Nothing
             else 
                Just n

test221 = noEmpty "abc" == Just "abc"
test222 = noNegative (-5) == Nothing
test223 = noNegative 5 == Just 5

--b)
cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString "" _ _ = Nothing
cowFromString s v g = if noNegative v /= Nothing && noNegative g /= Nothing then 
                     Just (Cow s v g)
                        else Nothing

--c)
cowFromString2 :: String -> Int -> Int -> Maybe Cow
-- cowFromString2 n a w = fmap (Cow) (noEmpty n) <*> noNegative a <*> noNegative w
cowFromString2 n a w = pure (Cow) <*> (noEmpty n) <*> noNegative a <*> noNegative w 

--3
newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)
data Person = Person Name Address
    deriving (Eq, Show)

--a)
validateLength :: Int -> String -> Maybe String
validateLength n l = if length (l) < n then Just l else Nothing 

test31 = validateLength 5 "abc" == Just "abc"

--b)

mkName :: [Char] -> Maybe Name
mkName s = if validateLength 25 s /= Nothing then Just (Name s) else Nothing 

mkAddress :: String -> Maybe Address
mkAddress str= if validateLength 100 str /=Nothing then Just (Address str) else Nothing

test32 = mkName "Gigel" == Just (Name "Gigel")
test33 = mkAddress "Str Academiei" == Just (Address "Str Academiei")

--c)
mkPerson :: String -> String -> Maybe Person
mkPerson sir1 sir2 = if mkName sir1 /= Nothing && mkAddress sir2 /= Nothing then 
                            Just (Person(Name sir1) (Address sir2)) 
                        else Nothing

--d)
mkName1 :: [Char] -> Maybe Name
mkName1 s = Name <$> validateLength 25 s             

mkPerson1 :: String -> String -> Maybe Person
mkPerson1 sir1 sir2 = Person <$> mkName sir1 <*> mkAddress sir2  


--                                      LABORATOR 12 

elem :: (Foldable t, Eq a) => a -> t a -> Bool
elem cautat = foldr cmp False
    where 
        cmp val soFar 
            | val == cautat = True 
            | otherwise = soFar 

null1 :: (Foldable t) => t a -> Bool
null1 l = foldr f True l  
        where 
            f val acc = acc && False

length1 :: (Foldable t) => t a -> Int
length1 l= foldr nr 0 l
    where 
        nr val acc = acc+1

toList1 :: (Foldable t) => t a -> [a]
toList1 l = foldr f [] l
           where f val acc = val : acc 

fold1 :: (Foldable t, Monoid m) => t m -> m
fold1 =  foldMap funct
    where funct m = m

--2 
data Constant a b = Constant b
instance Foldable (Constant a) where
    foldMap  f (Constant b) = f b

data Two2 a b = Two2 a b
instance Foldable (Two2 a) where 
    foldMap f (Two2 a b) = f b
    
data Three2 a b c = Three2 a b c
instance Foldable (Three2 a b) where
    foldMap f (Three2 a b c)= f c

data Three'2 a b = Three'2 a b b
instance Foldable (Three'2 a) where 
    foldMap f (Three'2 a b c) = f b <> f c
 
data Four'2 a b = Four'2 a b b b
instance Foldable (Four'2 a) where 
    foldMap f (Four'2 a b c d) = f b <> f c <> f d

data GoatLord2 a = NoGoat2 | OneGoat2 a | MoreGoats2 (GoatLord2 a) (GoatLord2 a) (GoatLord2 a)
instance Foldable (GoatLord2) where 
    foldMap f NoGoat2 = mempty
    foldMap f (OneGoat2 a) = f a
    foldMap f (MoreGoats2 a b c) = foldMap f a <> foldMap f b <> foldMap f c 


--                                        LABORATOR 13

{- Monada Maybe este definita in GHC.Base 

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing


instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)       

instance Functor Maybe where              
  fmap f ma = pure f <*> ma   
-}
--1
pos :: Int -> Bool
pos  x = if (x>=0) then True else False

fct :: Maybe Int ->  Maybe Bool
fct  mx =  mx  >>= (\x -> Just (pos x))

fct1 :: Maybe Int -> Maybe Bool
fct1 mx = do
        x<-mx
        return $ pos x

--2
addM :: Maybe Int -> Maybe Int -> Maybe Int
addM mx my = do
            x<-mx
            y<-my
            return $ x+y

addM2 :: Maybe Int -> Maybe Int -> Maybe Int
addM2 mx my = mx >>= (\x -> my>>= (\y-> return $ x+y))

--3
cartesian_product :: Monad m => m a -> m b -> m (a, b)
cartesian_product xs ys = xs >>= ( \x -> (ys >>= \y-> return (x,y)))

cartesian_product2 :: Monad m => m a -> m b -> m (a, b) 
cartesian_product2 xs ys = do 
    x <-xs
    y <-ys
    return $ (x,y)


prod :: (t1 -> t2 -> a) -> [t1] -> [t2] -> [a]
prod f xs ys = [f x y | x <- xs, y<-ys]

prod2 :: (t1 -> t2 -> a) -> [t1] -> [t2] -> [a]
prod2 f xs ys = do 
    x <- xs
    y <- ys
    return $ f x y


fff:: Int->Int->Int
fff x y = x+y



myGetLine2 :: IO String
myGetLine2 = do
        fin <- getChar
        if fin == '\n' then
          return []
        else
            myGetLine2 >>= \xs -> return (fin:xs)

myGetLine :: IO String
myGetLine = getChar >>= \x ->
      if x == '\n' then
          return []
      else
          myGetLine >>= \xs -> return (x:xs)
--4
prelNo :: Floating a => a -> a
prelNo noin =  sqrt noin
ioNumber = do
     noin  <- readLn :: IO Float
     putStrLn $ "Intrare\n" ++ (show noin)
     let  noout = prelNo noin
     putStrLn $ "Iesire"
     print noout

stringToFloat :: String -> Float
stringToFloat str = foldl (\acc x -> acc * 10 + fromIntegral (digitToInt x)) 0 str

ioNumber2 :: IO ()
ioNumber2 = getLine >>= \x -> 
        putStrLn $ "Intrare\n" ++ x ++  "\nIesire\n" ++ (show (prelNo (stringToFloat x)))



-- ioNumber3::IO()       
-- ioNumber3 =
--   readLn :: IO Float >>= \noin ->
--   putStrLn ("Intrare\n" ++ show noin) >>
--   let noout = prelNo noin in
--   putStrLn "Iesire" >>
--   print noout
-- 
--5


--- Monada Writer

newtype WriterS a = Writer { runWriter :: (a, String) } 


instance  Monad WriterS where
  return va = Writer (va, "")
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 ++ log2)


instance  Applicative WriterS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance  Functor WriterS where              
  fmap f ma = pure f <*> ma     

tell :: String -> WriterS () 
tell log = Writer ((), log)
  
logIncrement :: Int  -> WriterS Int
logIncrement x = do 
                tell ("Incremented" ++ show x ++ "\n")
                return (x+1)

logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x n = if n==1 then
                        logIncrement x
                    else do 
                        y<-logIncrement x
                        logIncrementN y (n-1) 
   
                  

--6
data Person1 = Person1 { name1 :: String, age1 :: Int }

showPersonN :: Person1 -> String
showPersonN ( Person1 s _) = "Name: " ++ s

showPersonA :: Person1 -> String
showPersonA (Person1 _ a) = "Age: " ++ (show a)

{-
showPersonN $ Person "ada" 20
"NAME: ada"
showPersonA $ Person "ada" 20
"AGE: 20"
-}

showPerson :: Person1 -> String
showPerson pers=  showPersonN pers ++ showPersonA pers

{-
showPerson $ Person "ada" 20
"(NAME: ada, AGE: 20)"
-}

--6.3
newtype Reader env a = Reader { runReader :: env -> a }


instance Monad (Reader env) where
  return x = Reader (\ _ -> x)
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env



instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance Functor (Reader env) where              
  fmap f ma = pure f <*> ma    


-- myGetLine2 :: IO String
-- myGetLine2 = do
--         fin <- getChar
--         if fin == '\n' then
--           return []
--         else
--             myGetLine2 >>= \xs -> return (fin:xs)
per=Person1 "ada" 20

mshowPersonN1 :: Reader Person1 String
mshowPersonN1 = do
  person <- Reader id
  return $ "Name: " ++ name1 person 

mshowPersonA ::  Reader Person1 String
mshowPersonA =do
            person <- Reader id
            return $ "Age: " ++ show (age1 person) 

mshowPerson ::  Reader Person1 String
mshowPerson = do
            person <- Reader id
            return $ "Name: " ++ name1 person ++ " Age: " ++ show (age1 person) 
{-
runReader mshowPersonN1  $ Person1 "ada" 20
"NAME:ada"
runReader mshowPersonA  $ Person1 "ada" 20
"AGE:20"
runReader mshowPerson  $ Person1 "ada" 20
"(NAME:ada,AGE:20)"
-}