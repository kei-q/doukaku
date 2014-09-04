module Main where

import Data.Ord (comparing)
import Data.List (sortBy)
import Data.List.Split (splitOneOf)

type User = String

solve :: String -> String
solve input = show $ sum costs
  where
    (cost, users) = parseInput input
    [pa,pc,pi] = map (flip filterUsers users) "ACI"
    costs = map (calcCostUsers cost) [pa,pc,filterI (length pa * 2) pi]

parseInput :: String -> (Int, [User])
parseInput input = (read cost, users)
  where
    (cost:users) = splitOneOf ":," input

filterUsers :: Char -> [User] -> [User]
filterUsers c = filter ((==c) . head)

calcCostUsers :: Int -> [User] -> Int
calcCostUsers cost users = sum $ zipWith ($) (map calcCost users) $ repeat cost

calcCost :: User -> (Int -> Int)
calcCost (_:'p':[]) = const 0
calcCost (c:'w':[]) = div2 . calcCost' c
calcCost (c:_) = calcCost' c

calcCost' 'A' = id
calcCost' _ = div2

div2 cost = if n `mod` 10 == 5 then n + 5 else n
  where n = cost `div` 2

filterI :: Int -> [User] -> [User]
filterI n = drop n . sortI

sortI :: [User] -> [User]
sortI = sortBy (comparing code)

code "Ip" = 3
code "In" = 1
code "Iw" = 2