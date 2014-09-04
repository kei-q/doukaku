module Solver where

solve :: String -> String
solve ns = show . maximum . (1:) . map apLength . patterns $ ns'
  where
    ns' = decode ns
    apLength (d,n) = fst $ foldl aux (2,n) ns'
      where aux (c,n) x = if x-n == d then (c+1,x) else (c,n)

decode :: String -> [Int]
decode = map $ \c -> length . takeWhile (/=c) $ ['0'..'9'] ++ ['a'..'z']

patterns :: [Int] -> [(Int,Int)]
patterns ns = [(n-m,n) | m <- ns, n <- dropWhile (<=m) ns]
