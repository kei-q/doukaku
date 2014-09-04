solve :: String -> String
solve input = show $ solve' [(0,read input)]

solve' ((n,0):_) = n
solve' ((n,x):xs)
  | odd x = solve' $ xs ++ [(n+1,x+1),(n+1,x-1)]
  | otherwise = solve' $ xs ++ [(n+1,x`div`2)]



