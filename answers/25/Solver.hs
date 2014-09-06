module Solver where

-- imports

import Data.List
import Data.List.Split
import Control.Lens
import Numeric.Lens
import qualified Doukaku as D

-- ghci用の値

t = "ss6cc24S"
pt = parse t

-- 定型句

type Input = [String]
type Output = String

solve :: String -> String
solve = format . solve' . parse

parse :: String -> Input
parse = splitOn ","

format :: Output -> String
format = id

-- main

type Field = [(Char, (Int,Int))]
type LastMoved = Field

initField :: Field
initField = zip ['a'..] [(x,y)| x <- [1..5], y <- [1..5]]

solve' :: Input -> Output
solve' input = if ret == "" then "none" else ret
  where
    ret = sort . map fst . snd . foldl step (initField,[]) $ input

step :: (Field,LastMoved) -> String -> (Field,LastMoved)
step (field,_) [c,d] = (field',pts')
  where
    field' = (field \\ pts) ++ pts'
    pts = targets field l t r b
    pts' = rotate (targets field l t r b)
    (Just (y1,x1)) = lookup c field
    (Just (y2,x2)) = lookup d field
    l = min x1 x2
    t = min y1 y2
    r = max x1 x2
    b = max y1 y2

targets field l t r b = go (points (l,t,r,b))
  where
    field' = map swap field
    go [] = []
    go (pt:pts) = case lookup pt field' of
      Just a -> (a,pt) : go pts
      Nothing -> go pts
    swap (a,b) = (b,a)

rotate ts = zip cs pts'
  where
    cs = map fst ts
    pts = map snd ts
    pts' = if null pts then pts else tail pts ++ [head pts]

--points :: (Int,Int,Int,Int) -> [(Int,Int)]
points (l,t,r,b) = nub $ concat [ls,ts,rs,bs]
--points (l,t,r,b) = [ls,ts,rs,bs]
  where
    ls = reverse $ sort [(y,l-1)| y <- [t-1..b+1]]
    ts = sort [(t-1,x)| x <- [l-1..r+1]]
    rs = sort [(y,r+1)| y <- [t-1..b+1]]
    bs = reverse $ sort [(b+1,x)| x <- [l-1..r+1]]
