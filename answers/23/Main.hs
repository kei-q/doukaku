{-# LANGUAGE TupleSections #-}
module Main where

import Data.List.Split (splitOn)
import Data.Maybe (mapMaybe)
import Data.Array
import Control.Lens

type Field = Array Point Cell
type Point = (Int,Int)
type Cell = Char

-- 警告抑制のためのdummy
main :: IO ()
main = undefined

solve :: String -> String
solve = show . counts . parse

parse :: String -> Field
parse = array ((0,0), (4,4)) . zip points . concat . splitOn "/"

counts :: Field -> Int
counts field = subtract 1 . maximum $ map (count field (pred '0')) points

points :: [Point]
points = [(x,y) | x <- [0..4], y <- [0..4]]

count :: Field -> Cell -> Point -> Int
count field c point = 1 + maximum (map next list)
  where
    next (c', point') = if c < c' then count field c' point' else 0
    neighbor delta = access field (addTuple point delta)
    list = mapMaybe neighbor [(0,-1), (0,1), (-1,0), (1,0)]
    addTuple (x,y) (a,b) = (x+a,y+b)

access :: Field -> Point -> Maybe (Cell, Point)
access field point = fmap (,point) $ field ^? ix point
