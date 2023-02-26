
--244_V2_PopescuVasileAlin_P1

data Prop = V String | T | F | And Prop Prop | Or Prop Prop
    deriving (Show, Eq)

class Operations exp where
 simplify :: exp -> exp

prop1 = And (Or (V "p") (V "q")) T
prop2 = Or prop1 (V "r")
prop3 = Or (And F (V "p")) (V "q")
prop4 = And prop3 (V "q")


p5=V "q"
instance Operations Prop where
    simplify (V a) = V a  
    simplify T =T
    simplify F=F

    simplify (Or _ T) = T
    simplify  (Or T _) = T
    simplify (Or p F) = simplify p
    simplify (Or F p) = simplify p

    simplify (And p T )= simplify p
    simplify (And T p)= simplify p
    simplify (And p F) = F
    simplify (And F p )= F    
    
    --vom lua pe cazuri, in functie de valoarea simplificata a prop

    simplify (And a b) =  if  (simplify a)==F ||  (simplify b) ==F then F  --cazul F && p = p && F = F
                            else if (simplify a)==T then (simplify b)       -- cazul T && p = p
                                else if (simplify b)==T then (simplify a)   -- cazul p && T=p
                                    else (And  (simplify a) (simplify b))   --cazul de p && t 


    --vom lua pe cazuri, in functie de valoarea simplificata a prop

    simplify (Or a b )= if  (simplify a)==T || (simplify b) ==T then T      --cazul T || p = p || t = T
                            else if (simplify a)==F then (simplify b)       -- cazul F || p=p
                                else if (simplify b)==F then (simplify a)   -- cazul p || F=p
                                    else (Or  (simplify a) (simplify b))    --cazul de p && t 

