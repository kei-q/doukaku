import Data.List

solve :: String -> String
solve = show . solve'

solve' :: String -> Int
solve' s
  | null pairs = if null s then 0 else 1
  | otherwise = 2 + maximum (map solve' pairs)
  where
    pairs = findPair s

findPair :: String -> [String]
findPair [] = []
findPair (c:cs)
  | any (==c) cs = pair : findPair cs
  | otherwise = findPair cs
  where pair = tail $ dropWhile (/=c) (reverse cs)
