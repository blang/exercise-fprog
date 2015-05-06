module Task4 where

data BoolFun = BF { numberArgs::Int, bfun::[Bool]->Bool}

g1::[Bool] -> Bool
g1 [x,y] = x && not y

g2::[Bool] -> Bool
g2 [x,y,z] = x || y || z

g3::[Bool] -> Bool
g3 [x,y] = x && not x

gfun1::BoolFun
gfun1 = BF { numberArgs= 2, bfun= g1}

gfun2::BoolFun
gfun2 = BF { numberArgs= 3, bfun= g2}

gfun3::BoolFun
gfun3 = BF { numberArgs= 2, bfun= g3}


isSatisfiable :: BoolFun -> Maybe [Bool]
isSatisfiable f = let 
					r = solutions f
				  in case null r of
					True -> Nothing
					False -> Just $ head r

isSatisfiableAll :: BoolFun -> Maybe [[Bool]]
isSatisfiableAll f = 
					let 
						r = solutions f
				  	in case null r of
						True -> Nothing
						False -> Just r 

-- Find all solutions
-- solutions gfun2 = [[True,False,False],[False,True,False],[True,True,False],[False,False,True],[True,False,True],[False,True,True],[True,True,True]]
solutions :: BoolFun -> [[Bool]]
solutions (BF {numberArgs=n, bfun=f}) = [x | x<-(combs n), f x == True]

-- All combination for n-tuples
-- combs 2 = [[False,False],[True,False],[False,True],[True,True]]
combs :: Int -> [[Bool]]
combs 0 = []
combs n = (nTimes (n-1) aBool) [[False], [True]]

-- Add one level of bool combinations
-- aBool [[True],[False]] = [[False,True],[True,True],[False,False],[True,False]]
aBool :: [[Bool]] -> [[Bool]]
aBool [] = []
aBool (x:xs) =  (False:x): (True:x) : aBool xs

nTimes :: Int -> (a -> a) -> (a -> a)
nTimes a f    | a <=0 = error "Zero or less times function"
              | a == 1 = f
              | otherwise  = f . (nTimes (a-1) f)