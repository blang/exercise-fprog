bintree :: Int -> Int -> Int -> Int -> [(Int,Int)]
bintree 0 0 0 0 = []
bintree w c t n
	| (w-1) <= c = []
	| n == t = (n,c+1):bintree w (c+1) (c+1) 0
	| otherwise = (n,c+1):bintree w (c+1) t (n+1)
	