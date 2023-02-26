--244_V2_PopescuVasileAlin_P2
import Data.Char

--domnu supraveghetor a zis ca e ok sa folosesc si idDigit 
--daca nu era permis voi implementa varianta 2 tot recursiv

--v1 --luam toate literele si aplicam modificarea corespunzatoare acesteia
f :: String -> String
f [] =[]
f (h:t) 
    |isDigit h = '-' : f t  --daca e cifra
    |isUpper h = (toLower h): f t   --daca e litera mare
    |otherwise = h : f t    --altecva

--varianta 2
f2 :: String -> String
f2 [] =[]
f2 (h:t) 
    |isAlphaNum h && not (isUpper h) && not (isLower h) = '-' : f2 t --daca e cifra
    |isAlphaNum h && isUpper h = (toLower h): f2 t --daca e litera mare
    |isAlphaNum h && isLower h = h: f t --daca e litera mica
    |otherwise = h : f2 t   --alta varianta

--varianta 3 folosinf monade

f3 :: String -> String

f3 str =do
    h<-str
    if isAlphaNum h && not (isUpper h) && not (isLower h) then
        return $ '-'
    else
        if isAlphaNum h && isUpper h then  
            return $ toLower h
        else
            if isAlphaNum h && isLower h then
                return h
            else return h    
