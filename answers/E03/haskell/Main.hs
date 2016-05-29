module Main where

import Data.List
import Data.List.Split

main :: IO ()
main = undefined

solve :: String -> String
solve = show . solve' . chunksOf 2

solve' input = count pairs input + if "00" `elem` input then 0 else count pairs1 input
  where
    pairs = pairs00 ++ pairs'
    pairs1 = map (\c -> [['1',c]]) ['a'..'t']

count pairs input = length $ filter ((==1) . length . intersect input) pairs

list = 't' : ['a'..'t']
mkPoint ns cs = [[a,b] | b <- cs, a <- ns]

pairs00 = map (\(a,b) -> ["00",a,b]) $ zip list' (tail list')
  where
    list' = mkPoint ['1'] list

pairs' = concatMap split3 $ map (\t -> mkPoint t list) target
  where
    target = ["12","23","34","45"]
    split3 xs@(a:b:c:_) = [a,b,c] : split3 (tail xs)
    split3 _ = []
