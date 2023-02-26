import Distribution.Simple.Program.HcPkg (list)

data List a = Nil
            | Cons a (List a)
        deriving (Eq, Show)

instance Functor List where 
    fmap _ Nil = Nil
    fmap f (Cons x xs) =Cons (f x) (fmap f xs)

instance Applicative List where
    pure x = Cons x Nil 
    Nil <*> _ = Nil
    Cons f listF <*> listElem = lappend (fmap f listElem)  (listF <*> listElem) 
                                where 
                                    lappend Nil list = list
                                    lappend (Cons a list1)  list2 = Cons a (lappend list1 list2)

--2
data Cow = Cow {
                name :: String, 
                age :: Int, 
                weight :: Int
                } deriving (Eq, Show)

--a
noEmpty :: String -> Maybe String
noEmpty "" = Nothing
noEmpty s = Just s

noNegative :: Int -> Maybe Int
noNegative x =  if x<=0 then Nothing 
                else Just x  

--b
cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString n a w = 
    case noEmpty n of 
        Nothing->Nothing
        Just n ->case noNegative a of
                 Nothing->Nothing
                 Just a ->  case noNegative w of 
                            Nothing->Nothing
                            Just w -> Just(Cow n a w)

--c
cowFromString2 :: String -> Int -> Int -> Maybe Cow
-- cowFromString2 n a w = fmap (Cow) (noEmpty n) <*> noNegative a <*> noNegative w  

--sau
-- cowFromString2 n a w = Cow <$> (noEmpty n) <*> noNegative a <*> noNegative w 

-- sau
cowFromString2 n a w = pure (Cow) <*> (noEmpty n) <*> noNegative a <*> noNegative w 

test25 = cowFromString2 "Milka" 5 100 == Just (Cow {name = "Milka", age = 5, weight = 100})


--3
newtype Name = Name String deriving (Eq, Show)
newtype Address = Address String deriving (Eq, Show)
data Person = Person Name Address
                deriving (Eq, Show)

validateLength :: Int -> String -> Maybe String
validateLength n s= if length s>n then Nothing 
                    else Just s

mkName :: String -> Maybe Name
mkName name = Name <$> validateLength 25 name 
mkAddress :: String -> Maybe Address
mkAddress address= Address <$> validateLength 100 address

--c
mkPerson :: String -> String -> Maybe Person
mkPerson n a = Person <$> mkName  n <*> mkAddress a

