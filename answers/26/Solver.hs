module Solver where

import Data.List
import Data.List.Split

t = "bdelmnouy"

type Input = String
type Output = [Int]

solve :: String -> String
solve = format . solve'

format :: Output -> String
format ls = intercalate "," $ map show ls

-- main

solve' :: Input -> Output
solve' xs = map (\n -> length xs - n*2) $ neighbors xs

neighbors :: Input -> [Int]
neighbors xs = map (count xs) [rlines, glines, blines]

count :: String -> [String] -> Int
count xs = length . filter (\p -> length (xs `intersect` p) == 2)

makeField :: Int -> [(Int,Int,Int,Int)]
makeField limit = takeWhile (\(c,_,_,_) -> c<=limit) $ go 1 2
  where
    go count n = map three (take count [n,n+2..]) ++ go (count+1) (n+count*2+1)
      where
        three n = (n, n-1, n-count*2, n+1)

roots = makeField 25
rlines = map (\(c,r,_,_) -> map n2c [r,c]) roots
blines = map (\(c,_,b,_) -> map n2c [b,c]) roots
glines = map (\(c,_,_,g) -> map n2c [c,g]) roots

n2c :: Int -> Char
n2c n = toEnum $ fromEnum 'a' + n
