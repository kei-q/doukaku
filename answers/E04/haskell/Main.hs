module Main where

-- template

import Data.List
import Data.List.Split
import Control.Lens
import Numeric.Lens
import Debug.Trace
import Data.Char

main :: IO ()
main = undefined

t :: Show a => a -> b -> b
t = traceShow
ti :: Show a => a -> a
ti = traceShowId
(.!) g f x = g (ti (f x))

type Input = ([(Int,Int)],Char)
type Output = String

solve :: String -> String
solve = format . solve' . parse

parse :: String -> Input
parse source = (routes,head c)
  where
    [rs,c] = splitOn ":" source
    routes = zip (map (\c -> (read [c] :: Int) - 1) rs) [0..]

-- Nothingや[]のケースはここでformatする
format :: Output -> String
format = id

-- main

type Routes = [(Int,Int)]

solve' :: Input -> Output
solve' (rs, c) = check rs c

clumber = zip ['A'..'H'] [0..]

check rs c = map fst $ filter (not . snd) $ zip ['A'..] $ clumb rs c

clumb rs c
  | block rs a == [] = map (==c) ['A'..'H']
  | otherwise = map (\r -> (r `intersect` (block rs a)) /= []) (routes rs)
  where
    a = ord c - ord 'A'

routes rs = map (\(c,p) -> route (reverse rs) p) clumber

block :: Routes -> Int -> Routes
block rs = route rs

route :: Routes -> Int -> Routes
route [] _ = []
route ((e,i):rs) n
  | e == n     = (e,i) : route rs ((n+1) `mod` 8)
  | e == rot n = (e,i) : route rs (rot n)
  | otherwise = route rs n

rot n = (n+7) `mod` 8
