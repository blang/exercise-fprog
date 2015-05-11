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

-- Teilaufgabe b
foldBTree :: (a->b) -> (b -> a -> b -> b) -> BTree a -> b
foldBTree f g (Leaf x) = f x
foldBTree f g (Node l m r) = g (foldBTree f g l) m (foldBTree f g r)

-- Teilaufgabe c
preOrderBTreeLeaf :: a->[a]
preOrderBTreeLeaf x = [x]

preOrderBTreeNode :: [b] -> b -> [b] -> [b]
preOrderBTreeNode l m r = [m] ++ l ++ r

testPreOrder = foldBTree preOrderBTreeLeaf preOrderBTreeNode testBaum == preOrder testBaum

-- Hilfsfunktionen
preOrder :: BTree a -> [a]
preOrder (Leaf x) = [x]
preOrder (Node x y z) = y : (preOrder x) ++ (preOrder z)

inOrder :: BTree a -> [a]
inOrder (Leaf x) = [x]
inOrder (Node x y z) = (inOrder x) ++ [y] ++ (inOrder z)

postOrder :: BTree a -> [a]
postOrder (Leaf x) = [x]
postOrder (Node x y z) = (postOrder x) ++ (postOrder z) ++ [y]