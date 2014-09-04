module Solve where

-- for SublimeHaskell
import Prelude

import Data.List (intercalate)

type Customer = [Bool]
type Line = [Customer]

-- 各レジの処理能力
regis :: [Int]
regis = [2,7,3,5,2]

solve :: String -> String
-- solve = dump . foldl solve' (replicate (length regis) [])

-- for LT
solve = dump . last . hoge
hoge = scanl solve' (replicate (length regis) [])

dump :: Line -> String
dump r = intercalate "," $ map (show . length) r

solve' :: Line -> Char -> Line
solve' line '.' = consume line
solve' line 'x' = wait line [False]
solve' line c   = wait line $ replicate (read [c]) True



consume :: Line -> Line
consume line = map consume' $ zip regis line

consume' :: (Int,Customer) -> Customer
consume' (n,bs)
  | and (take n bs) = drop n bs
  | otherwise = dropWhile id bs



wait :: Line -> Customer -> Line
wait line customer = update line (target line) customer

target :: Line -> Int
target line = length $ takeWhile (/=min') $ counts
  where
    min' = minimum counts
    counts = map length line

update :: Line -> Int -> Customer -> Line
update ls n c = let (a,(b:bs)) = splitAt n ls in a ++ ((b++c) : bs)