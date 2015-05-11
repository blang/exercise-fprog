module Task2 where

data BTree a = Leaf a | Node (BTree a) a (BTree a) deriving Show

testBaum :: Num a => BTree a
testBaum = Node (Node (Leaf 2) 5 (Leaf 7)) 10 (Node (Leaf 12) 15 (Leaf 20))
--     10
--   5    15
--  2 7  12 20

-- Teilaufgabe a
mapBTree :: (a -> b) -> BTree a -> BTree b
mapBTree f (Leaf x) = (Leaf (f x))
mapBTree f (Node x y z) = (Node (mapBTree f x) (f y) (mapBTree f z))

depthFirstPre :: BTree a -> [a]
depthFirstPre (Leaf x) = [x]
depthFirstPre (Node x y z) = y : (depthFirstPre x) ++ (depthFirstPre z)

depthFirstIn :: BTree a -> [a]
depthFirstIn (Leaf x) = [x]
depthFirstIn (Node x y z) = (depthFirstIn x) ++ [y] ++ (depthFirstIn z)

depthFirstPost :: BTree a -> [a]
depthFirstPost (Leaf x) = [x]
depthFirstPost (Node x y z) = (depthFirstPost x) ++ (depthFirstPost z) ++ [y]

breadthFirst :: BTree a -> [a]
breadthFirst (Leaf x) = [x]
breadthFirst (Node x y z) = (breadthFirst x) ++ [y] ++ (breadthFirst z)


