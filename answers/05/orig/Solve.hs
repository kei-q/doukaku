module Solve(solve) where

import Data.List
import Data.Char
import qualified Data.String.Utils as SU

type Cards = [String]
data Card = Card Suit Rank
type Suit = Char
type Rank = Char

toRank 'T' = 10
toRank 'J' = 11
toRank 'Q' = 12
toRank 'K' = 13
toRank 'A' = 14
toRank '2' = 15
toRank 'o' = 16
toRank c = ord c - ord '0'

solve s = pickup ((`div`2) $ length a) rank b'
    where
        [a,b] = SU.split "," s
        a' = parts a
        b' = parts b
        rank
          | a !! 1 == 'o' = toRank $ a !! 3
          | otherwise = toRank $ a !! 1

parts = map addRank . groupBy (\a b -> last a == last b) . sortBy (\a b -> toRank (last a) `compare` toRank (last b)) . parts'
parts' [] = []
parts' s = take 2 s : parts' (drop 2 s)

addRank ss@(s:_) = (toRank $ last s, ss)

pickup :: Int -> Int -> [(Int,[String])] -> [[[String]]]
pickup len rank yama = map conv $ filterLength len $ filterRank rank $ yama
  where
    conv (r,suit) = filter ((==len) . length) $ subsequences suit

filterRank rank = filter ((>rank) . fst)
filterLength len = filter ((>=len) . length . snd)

