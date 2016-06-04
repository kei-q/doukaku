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
    -- oops!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    [rs,c] = splitOn ":" source
    routes = zip (map (\c -> (read [c] :: Int) - 1) rs) [0..]

-- Nothingや[]のケースはここでformatする
format :: Output -> String
format = id

-- main

type Routes = [(Int,Int)]

solve' :: Input -> Output
solve' input = map fst $ filter (not . snd) $ zip ['A'..] $ clumb input

clumb (rs,c)
  | block == [] = map (==c) ['A'..'H']
  | otherwise = map (\r -> (r `intersect` block) /= []) (routes rs)
  where
    block = route rs a
    a = ord c - ord 'A'

routes rs = map (\(c,p) -> route (reverse rs) p) clumber
clumber = zip ['A'..'H'] [0..]

route :: Routes -> Int -> Routes
route [] _ = []
route ((e,i):rs) n
  | e == n      = (e,i) : route rs (next n)
  | e == prev n = (e,i) : route rs (prev n)
  | otherwise = route rs n

prev n = (n+7) `mod` 8
next n = (n+1) `mod` 8
