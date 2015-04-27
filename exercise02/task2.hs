module Task2 where
-- Funktioniert, laeuft unendlos,
-- beliebig grosse Zahlen dank Integer
part_a :: [Integer]
part_a = [0::Integer, 2^60..]

-- Laeuft, sollte aber bei  maxBound :: Int
-- 9223372036854775807 aufhoeren
part_b :: [Int]
part_b = [0::Int, 2^28..]

-- Laeuft
part_c :: [Int]
part_c = [0::Int, 2^31..]

-- Laeuft bis Ueberlauf
part_d :: [Int]
part_d = [0::Int, 2^32..]

-- Kleine Liste bis Ueberlauf
part_e :: [Int]
part_e = [0::Int, 2^60..]

-- Ueberlauf?
-- [0,-9223372036854775808]
part_f :: [Int]
part_f = [0::Int, 2^63..]

-- Nur [0,..], da Ueberlauf
part_g :: [Int]
part_g = [0::Int, 2^64..]

-- Grosse Zahlen bis 8,99e307, dann Infinityx2, dann NaN
part_h :: [Double]
part_h = [0::Double, 10^305..]