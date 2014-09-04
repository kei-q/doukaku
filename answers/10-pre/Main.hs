module Main where

import Debug.Trace
import Data.Char
import Data.List
import Data.List.Split
import Data.Function

--f # g = g . f
(f # g) a = traceShow a $ (g $ f a)

type Rank = Int
type Suit = Char
type Card = (Rank, Suit)

parse :: String -> [Card]
parse s = map toCard raw
  where
    raw = chunksOf 2 $ filter (/='0') s
toCard ['1',s] = (10,s)
toCard ['J',s] = (11,s)
toCard ['Q',s] = (12,s)
toCard ['K',s] = (13,s)
toCard ['A',s] = (14,s)
toCard [c,s] = (read [c], s)

solve :: String -> String
solve = check . parse

check cs
  | len == 5 && royal cs' = "RF"
  | len == 5 && seqs cs'  = "SF"
  | len == 5              = "FL"
  | seqs cs'              = "ST"
  | len == 4 && seqs cs'  = "4SF"
  | len == 4              = "4F"
  | forS cs'              = "4S"
  | otherwise             = "-"
  where
    cs' = undefined
    cs'' = undefined

--where
--    cs'' = sortSuits $ sortRanks cs
--    len = length cs'
--    cs' = target cs''

--forS cs = seqs' (init ranks) || seqs' (tail ranks)
--          || seqs' (init ranks') || seqs' (tail ranks')
--  where
--    ranks = sort $ map fst cs
--    ranks' = sort $ map toA ranks

--toA :: Int -> Int
--toA 14 = 1
--toA n = n

--sortRanks cs = sortBy (compare `on` fst) cs
--sortSuits cs = sortBy (compare `on` snd) cs

--royal cs = map fst cs == [10,11,12,13,14]
--seqs cs = seqs' (sort ranks) || seqs' (sort $ map toA ranks)
--  where
--    ranks = map fst cs

--seqs' ranks = ([1]==) $ nub $ zipWith (-) (tail ranks) ranks

--target :: [Card] -> [Card]
--target cards = last $ sortBy (compare `on` length) $ groupBy sameSuit cards

--sameSuit (_,s1) (_,s2) = s1 == s2
