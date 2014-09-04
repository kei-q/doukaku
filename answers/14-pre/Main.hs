import Data.List (tails)

solve :: String -> String
solve = show . sum . map count . concatMap mkPat . tails

mkPat :: String -> [(String,String)]
mkPat [] = []
mkPat (x:s) = [(l,tail r) | (l,r) <- sep s, head r == x]
  where sep s = map (flip splitAt s) [1..(length s - 1)]

count :: Pattern -> Int
count (l,r) = sum $ map (\c -> length $ filter (==c) r ) l

