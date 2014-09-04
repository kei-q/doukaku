{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import BasicPrelude
import Data.Text (splitOn)

solve :: Text -> Int
solve = length . f . parseInput
  where
    f [a,b] = l2ps a `intersect` l2ps b
    l2ps [a,b,c] = prod a b `union` prod a c

prod (x1,y1) (x2,y2) = [(x,y) | x <- range x1 x2, y <- range y1 y2]
  where range a b = [min a b .. max a b]

parseInput = map (map s2pos . splitOn "-") . splitOn ","
s2pos = (`divMod` 10) . read