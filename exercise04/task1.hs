module Task1 where
import Data.Char
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


makeUpper :: String -> (Int, String)
makeUpper l = (c, str) where
                red :: (Int, [Char]) -> Char -> (Int, [Char])
                red (x, y) n
                            | isLower n = (x+1, y ++ [(toUpper n)])
                            | otherwise = (x, y ++ [n])
                (c, str) = foldl red (0, []) l

testMakeUpper = makeUpper "LoremIpsum" == (8, "LOREMIPSUM")


evalPoly :: Num a => [a] -> a -> a
evalPoly l x =  let
                    red :: Num a => a -> a -> a -> a
                    red x a b = a+(b*x)
                in foldr1 (red x) l
testEvalPoly = evalPoly [3,2,0,5] 10 == 5023