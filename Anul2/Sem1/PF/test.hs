import Data.List

t= permutations [1,2,3]

maxim :: Integer -> Integer -> Integer
maxim x y = 
    if(x>y)
        then x
        else y
        
maxim3::Integer -> Integer -> Integer->Integer
-- maxim3 x y z = maxim x (maxim y z)
maxim3 x y z = 
    let 
        u = (maxim x y) 
    in 
        (maxim u z) 


maxim4:: Integer -> Integer -> Integer->Integer-> Integer
maxim4 x y z t = 
    let 
        a= (maxim x y)
        b= (maxim z t)
    in 
        (maxim a b ) 