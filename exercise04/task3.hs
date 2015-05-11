module Task3 where

-- Teilaufgabe a
data Polynomial a = Poly [a] deriving (Show)
eval :: Num a => (Polynomial a) -> a -> a
eval (Poly l) x = let
                    red :: Num a => a -> a -> a -> a
                    red x a b = a+(b*x)
                in foldr1 (red x) l

-- Teilaufgabe b
zipWithDefault :: (a -> a -> c) -> a -> [a]->[a]->[c]
zipWithDefault f _ []      []      = []
zipWithDefault f d (x:xs) (y:ys) = f x y : zipWithDefault f d xs ys
zipWithDefault f d [] (y:ys) = f d y : zipWithDefault f d [] ys
zipWithDefault f d (x:xs) [] = f x d : zipWithDefault f d xs []
--  zipWithDefault (+) 0 [1,2,3] [0,0,0,1,2,3] == [1,2,3,1,2,3]


polyAdd :: (Num a) => (Polynomial a) -> (Polynomial a) -> (Polynomial a)
polyAdd (Poly a) (Poly b) = Poly $ zipWithDefault (+) 0 a b

-- Teilaufgabe c
polyNegate :: (Num a) => Polynomial a -> Polynomial a 
polyNegate (Poly x) = Poly $ map (*(-1)) x

-- Teilaufgabe d
polyScalarMult :: (Num a) => a -> (Polynomial a) -> Polynomial a
polyScalarMult c (Poly a) = Poly $ map (*c) a

polyShiftR :: (Num a) => Polynomial a -> Polynomial a
polyShiftR (Poly xs) = Poly (0:xs)

polyMult :: (Num a) => Polynomial a -> Polynomial a -> Polynomial a
polyMult (Poly []) (Poly y) = Poly []
polyMult (Poly (x:xs)) cs = polyAdd (polyScalarMult x cs) (polyShiftR (polyMult (Poly xs) cs))

-- Teilaufgabe e
polyFromInteger :: (Num a) => Integer -> Polynomial a
polyFromInteger x = Poly [fromInteger x]

-- Teilaufgabe f
x :: (Num a) => Polynomial a
x = Poly [0, 1]

testPolyTerm = (3*x-x*(5-x))*(x*x-x)

-- Teilaufgabe g
instance (Num a) => Num (Polynomial a) where 
    a + b = polyAdd a b
    negate a = polyNegate a
    a * b = polyMult a b
    fromInteger a = polyFromInteger a
    signum a = error "Not implemented"
    abs a = error "Not implemented"

-- Tests
t1 :: Real b => Polynomial b
t1 = Poly [1,2,3,4]
t2 :: Real b => Polynomial b
t2 = Poly [0,0,0,0,1,2,3,4]
t3 :: Real b => Polynomial b
t3 = Poly [1,2,3]

-- Better Equals
instance (Num a, Eq a) => Eq (Polynomial a) where
    a == b = polyEquals a b

polyEquals :: (Num a, Eq a) => Polynomial a -> Polynomial a -> Bool
polyEquals (Poly []) (Poly []) = True
polyEquals (Poly []) (Poly (0:ys)) = polyEquals (Poly []) (Poly ys)
polyEquals (Poly []) (Poly (y:ys)) = False
polyEquals (Poly (0:xs)) (Poly []) = polyEquals (Poly xs) (Poly [])
polyEquals (Poly (x:xs)) (Poly []) = False
polyEquals (Poly (x:xs)) (Poly (y:ys)) 
                                    | x == y = polyEquals (Poly xs) (Poly ys)
                                    | otherwise = False
