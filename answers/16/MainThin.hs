module Main where

import Data.List (sort, group, intercalate, transpose)
import Data.List.Split (chunksOf)
import Control.Lens ((^.), (^?), re)
import Numeric.Lens (base)

type Line = [Char]
type Result = [Int]

solve :: String -> String
solve = showAnswer . solve' . parse 6
  where
    showAnswer = intercalate "," . map show

parse :: Int -> String -> [Line]
parse mapSize input = chunksOf mapSize $ tail bin
  where
    (Just n) = ('1':input) ^? base 8
    bin = n ^. re (base 2)

solve' :: [Line] -> Result
solve' ls = countLines $ findLines ls ++ findLines (transpose ls)
  where
    findLines = map findLines' . makePairs

countLines :: [[Int]] -> Result
countLines = map (subtract 1) . map length . tail . group . sort . (++[1,2,3,4,5,6]) . concat

findLines' :: (Line,Line) -> [Int]
findLines' (l1, l2) = go 0 l1 l2
  where
    go n [] _ = [n]
    go n _ [] = [n]
    go n (a:l1) (b:l2)
        | a == b = n : go 0 l1 l2
        | otherwise = go (n+1) l1 l2 -- 手抜き

makePairs :: [Line] -> [(Line,Line)]
makePairs line = zip line (tail line)

