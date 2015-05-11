module Task1 where

-- foldl :: (a -> b -> a) -> a -> [b] -> a

sumlen :: [Integer] -> Double
sumlen l = avg where
				red :: (Integer, Integer) -> Integer -> (Integer, Integer)
				red (a,b) x = (a+x, b+1)
				(sum, len) = foldl red (0,0) l
				avg = (fromIntegral sum) / (fromIntegral len)


sumlen' :: [Integer] -> Double
sumlen' l = avg where
				sum = foldl (+) 0 l
				len = toInteger $ length l
				avg = (fromIntegral sum) / (fromIntegral len)

testSumlen :: [Integer] -> Bool
testSumlen x = (sumlen x) == (sumlen' x)


