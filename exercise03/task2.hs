module Task2 where

--fac :: Integer -> Integer
fac :: Integral a => a -> a
fac n = if n==0 then 1 else n * fac (n-1)


-- facs 0 = [0!, 1!]
-- facs 1 = [0!, 1!, 2!]
-- Fakultaetszaehlen
facs :: Integer -> [Integer]
facs n = [k | i<-[0..n], let k = fac i]


-- genList f n = [f 0, f 1, ..., f (n-1)]
genList :: (Integer->a) -> Integer -> [a]
genList f n  = [k | i<-[0..(n-1)], let k = f i]

testGenList = genList id 10 == [0,1,2,3,4,5,6,7,8,9]

isPrime :: Integer->Bool
isPrime x = null [y | y<-[2..floor (sqrt (fromIntegral x))], x `mod` y == 0]


factors :: Integer->[Integer]
factors x = [y | y<-[2..(x-1)], x `mod` y == 0]
