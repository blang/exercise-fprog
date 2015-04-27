module Task3 where

twice :: (Int->Int) -> (Int->Int)
twice f = f . f

mul32 :: Int -> Int
mul32 x = x * 32

mul2 :: Int -> Int
mul2 x = x * 2

nTimesIf :: Int -> (Int -> Int) -> (Int -> Int)
nTimesIf a f = if a <= 0
                then error "Zero or less times function"
                else
                    if a == 1
                        then f
                        else f . (nTimesIf (a-1) f)

nTimesGuards :: Int -> (Int -> Int) -> (Int -> Int)
nTimesGuards a f    | a <=0 = error "Zero or less times function"
                    | a == 1 = f
                    | otherwise  = f . (nTimesGuards (a-1) f)
