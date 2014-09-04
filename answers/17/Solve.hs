module Solve where

import Data.List.Split (splitOn)

solve :: String -> String
solve input = show . cut b $ solve' a
  where [a,b] = splitOn "-" input

cut "bl" ((t,b),(l,r)) = b * l
cut "br" ((t,b),(l,r)) = b * r
cut "tl" ((t,b),(l,r)) = t * l
cut "tr" ((t,b),(l,r)) = t * r

solve' input = (folding $ hoge "TB", folding $ hoge "LR")
  where hoge source = [if x == head source then A else B | x <- input, x `elem` source]

data Pat = A | B

folding input = let (n,a,b) = foldl aux (1,0,0) input in (a,b)
aux (n,a,b) A = (n*2,n,a+b)
aux (n,a,b) B = (n*2,a+b,n)
