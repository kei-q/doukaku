
-- !! ./record.sh
data Tree = T Int Tree Tree | Empty

solve :: String -> String
solve input = show $ fst $ search queue
  where
    queue = initQ (makeTree (read input)) : walk nextQ queue
    search = head . filter pred
      where
        pred (_,(T x _ _)) | x == 0 = True
        pred _ = False

makeTree n
  | odd n = T n (makeTree (n-1)) (makeTree (n+1))
  | otherwise = T n Empty $ makeTree (n`div`2)

walk updater = walk'
  where
    walk' ((_,Empty) : q) = walk' q
    walk' ((a,T x l r) : q) = updater (a,l) : updater (a,r) : walk' q

initQ t = (0,t)
nextQ (info,t) = (info+1,t)