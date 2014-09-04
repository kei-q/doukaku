module Main where

import Data.List ()
import Data.List.Split (splitOn)
import Data.Char (digitToInt)
import Data.Maybe (catMaybes)

type Field = [[Int]]
type Point = (Int,Int)

main :: IO ()
main = undefined

solve :: String -> String
solve = show . (subtract 1) . counts . parse

parse :: String -> Field
parse = map (map digitToInt) . splitOn "/"

counts :: [[Int]] -> Int
counts field = maximum $ map (count field (-1)) points
  where
    points = [(x,y) | x <- [0..4], y <- [0..4]]

count :: Field -> Int -> Point -> Int
count field n (x,y) = 1 + maximum (map f list)
  where
    f (n', point')
      | n < n' = count field n' point'
      | otherwise = 0
    list = catMaybes [up, down, left, right]
    up = access field (x,y-1)
    down = access field (x,y+1)
    left = access field (x-1,y)
    right = access field (x+1,y)

access :: [[Int]] -> Point -> Maybe (Int, Point)
access field (x,y)
  | x < 0 || 4 < x = Nothing
  | y < 0 || 4 < y = Nothing
  | otherwise = Just $ (field !! y !! x, (x,y))