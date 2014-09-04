module Main where

import Data.List
import Data.List.Split

solve :: String -> String
solve input = if n < length patterns then patterns !! n else "-"
  where
    [nth, cards] = splitOn ":" input
    n = read nth - 1
    patterns = enumerate cards

enumerate :: String -> [String]
enumerate = nub . sort . filterCards . map (take 4) . concatMap permutations . check6

filterCards :: [String] -> [String]
filterCards = filter ((/= '0') . head)

check6 :: String -> [String]
check6 ns = map (rest ++) result
  where
    (six,rest) = partition (=='6') ns
    rep = tails . replicate (length six)
    result = zipWith (++) (rep '6') (reverse $ rep '9')
