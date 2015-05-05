module Task2 where

--fac :: Integer -> Integer
fac :: Integral a => a -> a
fac n = if n==0 then 1 else n * fac (n-1)


-- Fakultaetszaehlen
facs :: Integer -> [Integer]
-- facs 0 = [0!, 1!]
-- facs 1 = [0!, 1!, 2!]
facs n = [k | i<-[0..n], let k = fac i]


genList :: (Integer->a) -> Integer -> [a]
-- genList f n = [f 0, f 1, ..., f (n-1)]
genList f n  = [k | i<-[0..(n-1)], let k = f i]

testGenList = genList id 10

isPrime :: Integer->Bool
isPrime x = null [y | y<-[2..floor (sqrt (fromIntegral x))], x `mod` y == 0]


factors :: Integer->[Integer]
factors x = [y | y<-[2..(x-1)], x `mod` y == 0]


--https://stackoverflow.com/questions/4541415/haskell-prime-test
isPrime' :: Integer -> Bool
isPrime' x = null (filter (\y ->  x `mod`y == 0) (takeWhile (\y ->  y*y <= x) [2..]))
