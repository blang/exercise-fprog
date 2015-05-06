module Task3 where

reduceR :: (i -> o -> o) -> o -> [i] -> o
reduceR op init [] = init
reduceR op init (x:xs) = op x (reduceR op init xs)
treduceR = reduceR (-) 0 [1,2,3] == (1-(2-(3-0)))

reduceL :: (o -> i -> o) -> o -> [i] -> o
reduceL op init [] = init
reduceL op init (x:xs) = reduceL op (op init x) xs
treduceL = reduceL (-) 0 [1,2,3] == (((0-1)-2)-3)