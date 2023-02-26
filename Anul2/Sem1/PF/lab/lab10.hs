{-
class Functor f where
fmap : : ( a -> b ) -> f a -> f b
-}


data Two a b = Two a b
    deriving Show

instance Functor (Two a) where
    fmap :: (a2 -> b) -> Two a1 a2 -> Two a1 b
    fmap f (Two a x) = Two a (f x)

data Three a b c = Three a b c
    deriving Show

instance Functor (Three a b) where
    fmap :: (a2 -> b2) -> Three a1 b1 a2 -> Three a1 b1 b2
    fmap f (Three a b x) = Three a b (f x)

data Three' a b = Three' a b b
    deriving Show

instance Functor (Three' a ) where
    fmap f (Three' a x y) = Three' a (f x) (f y)

data Four a b c d = Four a b c d
    deriving Show

instance Functor (Four a b c) where
    fmap f (Four a b c x) = Four a b c (f x)







data Four'' a b = Four'' a a a b
     deriving Show

instance Functor (Four'' a) where
    fmap f (Four'' a b c x) = Four'' a b c (f x)    


data Quant a b = Finance | Desk a | Bloor b
     deriving Show
instance Functor (Quant a) where
    fmap _ Finance=Finance
    fmap _ (Desk a)=Desk a
    fmap f (Bloor b) = Bloor (f b)


data LiftItOut f a = LiftItOut (f a)
    deriving Show

instance Functor f => Functor (LiftItOut f) where
    fmap g (LiftItOut fa) =LiftItOut (fmap g fa) 

data Parappa f g a = DaWrappa (f a) (g a)
    deriving Show 

instance (Functor f,Functor g) => Functor (Parappa f g) where
    fmap h (DaWrappa fa  ga) =DaWrappa (fmap h fa) (fmap h ga)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
    deriving Show 

instance (Functor f,Functor g) => Functor (IgnoreOne f g a) where
    fmap h (IgnoringSomething fa  gb) = IgnoringSomething fa (fmap h gb)

data Notorious g o a t = Notorious (g o) (g a) (g t)
instance Functor g => Functor (Notorious g o a) where
    fmap :: Functor g => (a1 -> b) -> Notorious g o a a1 -> Notorious g o a b
    fmap h (Notorious go  ga gt) = Notorious go ga (fmap h gt)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
    deriving Show 

instance Functor GoatLord where
    fmap f  =go
        where 
            go NoGoat=NoGoat
            go (OneGoat a) = OneGoat (f a)
            go (MoreGoats l1 l2 l3) = MoreGoats (go l1) (go l2) (go l3)


data TalkToMe a = Halt | Print String a | Read (String -> a)