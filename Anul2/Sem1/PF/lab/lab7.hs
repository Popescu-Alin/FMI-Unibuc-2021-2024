import Distribution.SPDX (LicenseId(AFL_3_0, AFL_1_1))
--Nu se poate crea, edita sau încărca … Nu există suficient spațiu de stocare. Obțineți mai mult spațiu sau eliminați fișiere de pe Drive, din Google Foto sau Gmail.
--1
data Expr = Const Int -- integer constant
          | Expr :+: Expr -- addition
          | Expr :*: Expr -- multiplication
           deriving Eq

--1.1


instance Show Expr where
    show (Const a) =show a
    show ( a :+:  b) = show a ++ "+" ++ show b
    show (a :*: b ) =show a ++ "*" ++ show b


--1.2
evalExp:: Expr ->Int
evalExp (Const a)= a
evalExp (a :+: b) = evalExp a + evalExp b
evalExp (a :*: b) = evalExp a * evalExp b


exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))
exp2 = (Const 2 :*: (Const 3 :+: Const 4))
exp3 = (Const 4 :+: (Const 3 :*: Const 3))
exp4 = (((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2)
test11 = evalExp exp1 == 6
test12 = evalExp exp2 == 14
test13 = evalExp exp3 == 13
test14 = evalExp exp4 == 16


--1.3
data Operation = Add | Mult deriving (Eq, Show)

data Tree = Lf Int -- leaf
          | Node Operation Tree Tree -- branch
           deriving (Eq, Show)
evalArb :: Tree -> Int
evalArb (Lf a)= a
evalArb (Node Add a b) = evalArb a +evalArb b
evalArb (Node Mult a b) = evalArb a * evalArb b

arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))
arb2 = Node Mult (Lf 2) (Node Add (Lf 3)(Lf 4))
arb3 = Node Add (Lf 4) (Node Mult (Lf 3)(Lf 3))
arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3)(Lf 1))) (Lf 2)

test21 = evalArb arb1 == 6
test22 = evalArb arb2 == 14
test23 = evalArb arb3 == 13
test24 = evalArb arb4 == 16


expToArb :: Expr -> Tree
expToArb (Const a) = Lf a
expToArb (a :+: b) = Node Add (expToArb a) (expToArb b)
expToArb (a :*: b) = Node Mult (expToArb a) (expToArb b)

test31 = expToArb exp1 == arb1 
test32 = expToArb exp2 == arb2 
test33 = expToArb exp3 == arb3 
test34 = expToArb exp4 == arb4 


--2
class Collection c where
    empty :: c key value
    singleton :: key -> value -> c key value
    insert:: Ord key
        => key -> value -> c key value -> c key value
    clookup :: Ord key => key -> c key value -> Maybe value
    delete :: Ord key => key -> c key value -> c key value
    keys :: c key value -> [key]
    values :: c key value -> [value]
    toList :: c key value -> [(key, value)]
    fromList :: Ord key => [(key,value)] -> c key value
--2.1
-- toList-> lista de perechi de tipul (key,value)
    keys c = [fst p | p<-toList c ]
    values c = [snd p | p<-toList c]
    
    fromList [] = empty
    fromList ((k,v):l) = insert k v (fromList l)
--2.2
newtype PairList k v
  = PairList { getPairList :: [(k, v)] }


instance Collection PairList where
    empty = PairList[]
    singleton k v =PairList[(k,v)]
    insert k v (PairList l) = PairList ((k,v) : (filter (\x->fst x /=k) l ))
    clookup k p=lookup k (getPairList p)
    delete k (PairList l )=PairList $ filter (\x->fst x /=k) l 
    toList=getPairList






data SearchTree key value
  = Empty
  | BNode
      (SearchTree key value) -- elemente cu cheia mai mica
      key                    -- cheia elementului
      (Maybe value)          -- valoarea elementului
      (SearchTree key value) -- elemente cu cheia mai mare