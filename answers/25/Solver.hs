{-# LANGUAGE TupleSections #-}
module Solver where

-- imports

import Data.List
import Data.List.Split
import Control.Lens
import Numeric.Lens
import qualified Doukaku as D
import Data.Maybe
import Data.Tuple

-- ghci用の値

t = "ab,gg,uj,pt,an,ir,rr"
pt = parse t

-- 定型句

type Input = [String]
type Output = String

solve :: String -> String
solve = format . solve' . parse

parse :: String -> Input
parse = splitOn ","

format :: Output -> String
format "" = "none"
format output = output

-- main

type Field = [(Char, (Int,Int))]
type LastMoved = Field

initField :: Field
initField = zip ['a'..] [(x,y)| x <- [1..5], y <- [1..5]]

solve' :: Input -> Output
solve' = sort . map fst . snd . foldl step (initField,[])

step :: (Field,LastMoved) -> String -> (Field,LastMoved)
step (field,_) input = (field',pts')
  where
    field' = (field \\ pts) ++ pts'
    pts = targets field (ltrb field input)
    pts' = rotate pts

ltrb field [c1,c2] = (min x1 x2, min y1 y2, max x1 x2, max y1 y2)
  where
    (Just (y1,x1)) = lookup c1 field
    (Just (y2,x2)) = lookup c2 field

targets field = mapMaybe go . points
  where
    field' = map swap field
    go pt = fmap (,pt) $ lookup pt field'

rotate ts = zip cs pts'
  where
    (cs,pts) = unzip ts
    pts' = if null pts then pts else tail pts ++ [head pts]

points :: (Int,Int,Int,Int) -> [(Int,Int)]
points (l,t,r,b) = nub $ concat [ls,ts,rs,bs]
  where
    ls = reverse $ sort [(y,l-1)| y <- [t-1..b+1]]
    ts = sort [(t-1,x)| x <- [l-1..r+1]]
    rs = sort [(y,r+1)| y <- [t-1..b+1]]
    bs = reverse $ sort [(b+1,x)| x <- [l-1..r+1]]
