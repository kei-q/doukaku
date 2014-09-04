module Main where

import Data.List (sort, group, intercalate, transpose)
import Data.List.Split (chunksOf)
import Control.Lens ((^.), (^?), re)
import Numeric.Lens (base)

type Line = [Char]
type Result = [Int]

-- solve
-- =============================================================================
solve :: String -> String
solve = showAnswer . solve' . parse 6

-- parse
-- =============================================================================
parse :: Int -> String -> [Line]
parse mapSize input = chunksOf mapSize $ tail bin
  where
    -- 先頭の'0'が消えてしまわないように'1'をつける
    -- あとで2進数にした時に`tail`で消す
    (Just n) = ('1':input) ^? base 8
    bin = n ^. re (base 2)

-- solve'
-- =============================================================================
solve' :: [Line] -> Result
solve' ls = countLines $ findLines ls ++ findLines (transpose ls)
  where
    findLines = map findLines' . makePairs

-- countLines
-- --------------------------------------------------------
-- 存在しない長さのlineのcountが消えてしまわないように[1,2,3,4,5,6]を用意
-- 最後に`(-1)`して消す
countLines :: [[Int]] -> Result
countLines = map (subtract 1) . map length . tail . group . sort . (++[1,2,3,4,5,6]) . concat

-- findLines'
-- --------------------------------------------------------
findLines' :: (Line,Line) -> [Int]
findLines' (l1, l2) = go 0 l1 l2
  where
    go n [] _ = [n]
    go n _ [] = [n]
    go n (a:l1) (b:l2)
        | a == b = n : go 0 l1 l2
        | otherwise = go (n+1) l1 l2 -- 手抜き
    -- go n ('0':l1) ('0':l2) = n : go 0 l1 l2
    -- go n ('1':l1) ('0':l2) = go (n+1) l1 l2 -- 手抜き
    -- go n ('0':l1) ('1':l2) = go (n+1) l1 l2 -- 手抜き
    -- go n ('1':l1) ('1':l2) = n : go 0 l1 l2

-- makePairs
-- --------------------------------------------------------
makePairs :: [Line] -> [(Line,Line)]
makePairs line = zip line (tail line)

-- showAnswer
-- =============================================================================
showAnswer :: Result -> String
showAnswer = intercalate "," . map show

