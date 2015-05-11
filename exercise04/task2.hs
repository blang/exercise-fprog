module Task2 where

data BTree a = Leaf a | Node (BTree a) a (BTree a) deriving Show

--     10
--   5    15
--  2 7  12 20
testBaum :: Num a => BTree a
testBaum = Node (Node (Leaf 2) 5 (Leaf 7)) 10 (Node (Leaf 12) 15 (Leaf 20))

testBaumF1 :: Num a => BTree a
testBaumF1 = Node (Node (Leaf 2) 5 (Leaf 21)) 10 (Node (Leaf 12) 15 (Leaf 20))

testBaumF2 :: Num a => BTree a
testBaumF2 = Node (Node (Leaf 2) 5 (Leaf 7)) 10 (Node (Leaf 9) 15 (Leaf 20))


-- Teilaufgabe a
mapBTree :: (a -> b) -> BTree a -> BTree b
mapBTree f (Leaf x) = (Leaf (f x))
mapBTree f (Node x y z) = (Node (mapBTree f x) (f y) (mapBTree f z))

-- Teilaufgabe b
foldBTree :: (a->b) -> (b -> a -> b -> b) -> BTree a -> b
foldBTree f g (Leaf x) = f x
foldBTree f g (Node l m r) = g (foldBTree f g l) m (foldBTree f g r)

-- Teilaufgabe c
preOrder :: BTree a -> [a]
preOrder tree = let
                    preOrderBTreeLeaf :: a->[a]
                    preOrderBTreeLeaf x = [x]

                    preOrderBTreeNode :: [b] -> b -> [b] -> [b]
                    preOrderBTreeNode l m r = [m] ++ l ++ r
                in foldBTree preOrderBTreeLeaf preOrderBTreeNode tree

testPreOrder = preOrder testBaum == basicPreOrder testBaum

-- Teilaufgabe d
isSearchTree :: Ord a => (a -> a -> Bool) -> BTree a -> Bool
--isSearchTree f (Leaf x) = True
isSearchTree f tree =  res where
                        (res, _, _)= foldBTree leafFn (nodeFn f) tree

leafFn :: a -> (Bool, a, a)
leafFn x = (True, x, x)

nodeFn :: Ord a  => (a -> a -> Bool) -> (Bool, a, a) -> a -> (Bool, a, a) -> (Bool, a, a)
nodeFn f (lok, lmin, lmax) m (rok, rmin, rmax) = if (not lok) || (not rok) then
                                                    (False, lmin, rmax)
                                                else
                                                    let
                                                        ok1 = f lmax m
                                                        ok2 = not (f rmin m)
                                                        nmin = lmin
                                                        nmax = rmax
                                                    in (ok1 && ok2, nmin, nmax)



-- Hilfsfunktionen
basicPreOrder :: BTree a -> [a]
basicPreOrder (Leaf x) = [x]
basicPreOrder (Node x y z) = y : (basicPreOrder x) ++ (basicPreOrder z)

inOrder :: BTree a -> [a]
inOrder (Leaf x) = [x]
inOrder (Node x y z) = (inOrder x) ++ [y] ++ (inOrder z)

postOrder :: BTree a -> [a]
postOrder (Leaf x) = [x]
postOrder (Node x y z) = (postOrder x) ++ (postOrder z) ++ [y]