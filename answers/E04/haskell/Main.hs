module Main where

import Data.List
import Data.List.Split
import Debug.Trace

-- for deugging

t :: Show a => a -> b -> b
t = traceShow
ti :: Show a => a -> a
ti = traceShowId
(.!) g f x = g (ti (f x))

-- template

main :: IO ()
main = undefined

type Input = [String]
type Output = String

parse :: String -> Input
parse = splitOn ","

-- Nothingや[]のケースはここでformatする
format :: Output -> String
format = show

solve :: String -> String
solve = format . solve' . parse

-- main

solve' :: Input -> Output
solve' = intercalate ","
