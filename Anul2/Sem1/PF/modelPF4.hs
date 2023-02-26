--1

data ArbList a = Node a[(Char, ArbList a)] | Empty

arbore = Node 40 [('a', Node 20 [('a',Empty), ('b',Empty)]), ('b', Node 30 [('z',Empty), ('c',Empty)])]

arbore' = Node 40 [('a', Node 20 [('a',Empty), ('b',Empty)]), ('b', Node 30 [('z',Empty), ('c',Empty)])]

arbore'' = Node 40 [('a', Node 20 [('b',Empty), ('b',Empty)]), ('b', Node 35 [('z',Empty), ('c',Empty)])]

--a)
arb1::Integral a => ArbList a -> Integer
arb1 (Empty) = 0
arb1 (Node v []) = 0
arb1 (Node a ((c, b): xs)) = toInteger a + arb1 b + arb1 (Node 0 xs)


--b)
instance Eq a => Eq (ArbList a) where
  (Node x xs) == (Node y ys) = x == y && xs == ys
  Empty == Empty = True
  _ == _ = False

--2
data MyPair a b = P a b deriving Show
data MyList a = L [a] deriving Show 

class MyZip lp where 
    zipL :: lp a -> lp b -> lp (MyPair a b)
    unzipL :: lp (MyPair a b) -> MyPair (lp a ) (lp b)

instance MyZip MyList  where 
    zipL :: MyList a -> MyList b -> MyList (MyPair a b)
    zipL _ (L []) = L []
    zipL (L[]) _ = L []
    zipL (L xs) (L ys) = L $ zipWith P xs ys

    unzipL (L zs) = undefined

l1 :: MyList Integer
l1=L[1..3]
l2 :: MyList Integer
l2=L[4..6]