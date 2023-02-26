
--1
data Punct = Pt [Int]


showPt:: Punct ->String

showPt (Pt[]) ="" 
showPt (Pt(h:t))=if t/=[] then show h ++"," ++ showPt (Pt t) else show h

instance Show Punct where 
    show (Pt pct)= "(" ++ (showPt (Pt pct))++ ")"

data Arb = Vid | F Int | N Arb Arb
        deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a


f:: Arb -> [Int]
f Vid=[]
f (N (F s) d)= s: f d

instance ToFromArb Punct where
    toArb (Pt([])) =  Vid
    toArb (Pt(h:t)) = N (F h) (toArb $ Pt t) --(F h, toArb Pt(t))

    fromArb Vid =Pt []
    fromArb a= Pt(f a)

--2
--a
data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
    perimeter :: (Floating a) => g a -> a
    area :: (Floating a) => g a -> a


instance GeoOps Geo where
    perimeter (Square a) = 4*a
    perimeter (Rectangle a b) = 2*(a+b)
    perimeter (Circle a) = 2*a*pi
    
    area(Square a) = a*a
    area (Rectangle a b) = a*b
    area (Circle a) = a*a*pi

--b
instance (Floating a, Eq a) => Eq (Geo a) where
    a==b = perimeter a== perimeter b
    
