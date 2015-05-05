module Task1 where

sort2 :: Ord a => a -> a -> (a, a)
sort2 a b 
        | a<b = (a, b)
        | otherwise = (b, a)               


sort3 :: Ord a => a -> a -> a -> (a, a, a)
sort3 x y z = (low, mid, high) where
      (low_mid, mid_high1)  = sort2 x y
      (low, mid_high2)      = sort2 low_mid z
      (mid, high)           = sort2 mid_high1 mid_high2 
                
-- Naive Implementierung
sort3' :: Ord a => a -> a -> a -> (a, a, a)
sort3' x y z 
    | (x < y && z < x) = sort3' z y x
    | (x >= y && y < z) = sort3' y x z
    | (z < y) = sort3' x z y
    | otherwise = (x, y, z)





