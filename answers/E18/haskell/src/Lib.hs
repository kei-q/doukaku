module Lib (solve) where

import Data.List.Split (splitOn)
import Control.Lens
import Numeric.Lens

solve :: String -> String
solve = show . solve' . read

solve' :: Int -> Int
solve' n = calc ('0':(n+1) ^. re (base 2)) ^?! base 2

calc :: String -> String
calc [] = []
calc s@('0':'0':'0':_) = calc' s
calc s@('0':'1':'1':'1':_) = '1' : calc' (tail s)
calc (c:s) = c : calc s

calc' s = take (length s) $ cycle "001"
