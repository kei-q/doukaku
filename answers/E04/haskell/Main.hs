module Main where

-- template

import Data.List
import Data.List.Split
import Data.Char

main :: IO ()
main = undefined

type Input = (Routes,Char)
type Output = String

solve :: String -> String
solve = solve' . parse

parse :: String -> Input
parse source = (routes, head c)
  where
    -- oops!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    [rs,c] = splitOn ":" source
    routes = zip (map (\c -> (read [c] :: Int) - 1) rs) [0..]

-- main

type Routes = [(Int,Int)]

climbers = ['A'..'H']

solve' :: Input -> Output
solve' = map fst . filter (not . snd) . zip climbers . climb

climb :: (Routes, Char) -> [Bool]
climb (rs,c)
  | block == [] = map (==c) climbers
  | otherwise = map ((/=[]) . intersect block) (routes rs)
  where
    block = route rs a
    a = ord c - ord 'A'

routes :: Routes -> [Routes]
routes rs = map (route (reverse rs)) [0..7]

route :: Routes -> Int -> Routes
route [] _ = []
route (r@(e,_):rs) n
  | e == n      = r : route rs (next n)
  | e == prev n = r : route rs (prev n)
  | otherwise = route rs n

prev n = (n+7) `mod` 8
next n = (n+1) `mod` 8
