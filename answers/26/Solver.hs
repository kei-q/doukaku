{-# LANGUAGE TupleSections #-}
module Solver where

-- imports

import Data.List
import Data.List.Split
import qualified Doukaku as D
import Data.Maybe
import Data.Tuple

-- ghci用の値

t = "bdelmnouy"

-- 定型句

type Input = [String]
type Output = (Int,Int,Int)

solve :: String -> String
solve = format . solve'

format :: Output -> String
format (r,g,b) = intercalate "," [show r, show g, show b]

-- main

solve' :: String -> (Int,Int,Int)
solve' xs = let (r,g,b) = neighbor xs in (base-r*2,base-g*2,base-b*2)
  where
    base = length xs

neighbor :: String -> (Int,Int,Int)
neighbor xs = (count xs rlines, count xs glines, count xs blines)

count :: String -> [String] -> Int
count xs ls = length $ filter (\p -> length (xs `intersect` p) == 2) ls

rlines = ["bc","ef","gh","jk","lm","no","qr","st","uv","wx"]
glines = ["cd", "fg", "hi", "kl", "mn", "op", "rs", "tu", "vw", "xy"]
blines = ["ac", "bf", "dh", "ek", "gm", "io", "jr", "lt", "nv", "px"]
