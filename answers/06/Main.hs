module Main where

import Data.List.Split

solve :: String -> String
solve = solve' . parseInput

parseInput :: String -> [Int]
parseInput = map read . splitOn "->"

solve' :: [Int] -> String
solve' [m,n]
  |        m `isME`        n = "me"
  | calcMO m `isME`        n = "mo"
  |        m `isME` calcMO n = "da"
  |        m `isSI`        n = "si"
  | calcMO m `isSI`        n = "au"
  |        m `isSI` calcMO n = "ni"
  | calcMO m `isSI` calcMO n = "co"
  | otherwise = "-"
solve' _ = error "solve'"

isME, isSI :: Int -> Int -> Bool
isME m n = m == n
isSI m n = calcMO m == calcMO n && not (isME m n)

calcMO :: Int -> Int
calcMO n = (n+1) `div` 3
