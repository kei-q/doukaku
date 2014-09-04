module Solve where

import Data.List.Split

solve :: String -> String
solve input = show $ cut b $ solve' a 1 1 (0,0,0,0)
  where [a,b] = splitOn "-" input

solve' [] _ _ a = a
solve' ('L':cs) h v (t,b,l,r) = solve' cs (h*2) v (t,b,h,l+r)
solve' ('R':cs) h v (t,b,l,r) = solve' cs (h*2) v (t,b,l+r,h)
solve' ('T':cs) h v (t,b,l,r) = solve' cs h (v*2) (v,t+b,l,r)
solve' ('B':cs) h v (t,b,l,r) = solve' cs h (v*2) (t+b,v,l,r)

cut "bl" (t,b,l,r) = b * l
cut "br" (t,b,l,r) = b * r
cut "tl" (t,b,l,r) = t * l
cut "tr" (t,b,l,r) = t * r
