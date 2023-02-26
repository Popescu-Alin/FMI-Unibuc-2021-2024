import Data.List
import GHC.Float (float2Double)

type Nume = String

data Prop= Var Nume
            | F
            | T
            | Not Prop
            | Prop :|: Prop
            | Prop :&: Prop
            | Prop :=>: Prop
            | Prop :<=>: Prop
    deriving Eq
infixr 2 :|:
infixr 3 :&:


instance Show Prop where
    show :: Prop -> String
    show (Var a) =  a 
    show T = "true"
    show F = "False"
    show (Not p)= "(~" ++ show p ++ ")"
    show (a :|: b) = "("++show a ++ " | " ++ show b ++")"
    show (a :&: b) = "("++show a ++ " & " ++ show b ++")"

test_ShowProp :: Prop
test_ShowProp = Not (Var "P") :&: Var "Q" 

--3
-- lookup :: Eq a => a -> [(a,b)] -> Maybe b

type Env = [(Nume, Bool)]    

fromJust :: Maybe a -> a
fromJust (Just a) =a 

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a  = fromJust . lookup a 

eval :: Prop -> Env -> Bool
eval (Var a) ev = impureLookup a ev  
eval T ev = True 
eval F ev = False
eval (Not p) ev =  not (eval p ev)
eval (a :|: b) ev = eval a ev ||  eval b ev 
eval (a :&: b) ev = eval a ev &&  eval b ev 
test_eval :: Bool
test_eval = eval (Var "P" :|: Var "Q") [("P", True), ("Q", False)]

--4
variabile :: Prop -> [Nume]
variabile (Var a) = [a]
variabile (Not a) = nub (variabile a) 
variabile (a :|: b) = nub (variabile a ++ variabile b)
variabile (a :&: b) = nub (variabile a ++ variabile b)

test_variabile :: [Nume]
test_variabile =["a","b"] 

--5
var=[True,False] 
test4=test_variabile  
test = [(x,y)| y<-var, x<-test4]

test3 =permutations test 
test5 = filter f2 (nub ( map (f 2) (permutations test)))


f n l = sort (take n l) -- sortez lista de tupluri si iau n elemnete din ea
f2 l = length l == length  (nub  (map (\x-> fst x) l)) -- verific sa fie variabile diferite in tuple

-- permutations [(x,y)| y<-[True,False], x<-l] fac permutari o multime de tuluri.

envs :: [Nume] -> [Env]
envs l =  filter f2 (nub ( map (f (length l)) (permutations [(x,y)| y<-[True,False], x<-l]))) 

--6

satisfiabila :: Prop -> Bool
satisfiabila a = foldr (||) False [(eval a env ) | env<- envs (variabile a) ]


--7

valida :: Prop -> Bool
valida p = not (satisfiabila (Not p))


--8
echivalenta :: Prop -> Prop -> Bool
echivalenta a b = foldr (&&) True [(eval a env ) == (eval b env) | env<- envs (nub (variabile a ++variabile b)) ]

t=(Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))


