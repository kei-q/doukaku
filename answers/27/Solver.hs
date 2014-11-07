module Solver where

import Data.List
import Data.List.Split
import Data.Maybe

t = "befi"

type Input = String
type Output = [String]

type Pos = Char

solve :: String -> String
solve = format . solve'

format :: Output -> String
format = intercalate ","

-- main

solve' :: Input -> Output
solve' stops = case concatMap f "123" of
    [] -> ["-"]
    list -> list
  where
    f p = makePair p . cleaning . findDeadEnd rmap $ p
    rmap = enableRailMap stops

makePair :: Pos -> String -> [String]
makePair p = map (\c -> p:[c])

cleaning :: String -> String
cleaning = filter (`elem` "456") . nub . sort

findDeadEnd :: RailMap -> Pos -> [Pos]
findDeadEnd rmap p
  | Just poss <- findNext rmap p = concatMap (findDeadEnd rmap) poss
  | otherwise = [p]

findNext :: RailMap -> Pos -> Maybe [Pos]
findNext rmap p = lookup p rmap

type RailMap = [(Char,String)]

enableRailMap :: String -> RailMap
enableRailMap stops = filter (\(i,_) -> i `notElem` stops) railmap

railmap :: RailMap
railmap =
    [ ('1', "ag")
    , ('2', "dh")
    , ('3', "bf")
    , ('a', "b")
    , ('b', "c5")
    , ('c', "46")
    , ('d', "ce")
    , ('e', "5")
    , ('f', "g")
    , ('g', "ceh")
    , ('h', "4i")
    , ('i', "6")
    ]
