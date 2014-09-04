module Main where

import Data.List
import Data.List.Split
import qualified Data.Map as M
import Text.Printf

t = "8x6:6214,3024,5213,5022,0223,7115"

solve :: String -> String
solve input = printf "%02d" result
  where
    (size, rects) = parse input
    field = makeField size
    field' = insertRects field rects
    scores = initScores field'
    calcedScores = calcScores scores
    result = findResult size calcedScores

type Rect  = (Int,Int,Int,Int) -- x4
type Field = [Rect]
type Score = Int
type ScoreMap = [(Rect,Score)]

sample t = let (a,b) = parse t in initScores (insertRects (makeField a) b)

parse :: String -> ((Int,Int), [Rect] )
parse input = ((w,h),rects)
  where
    [a,b] = splitOn ":" input
    [w,h] = map read $ splitOn "x" a
    rawRects = if b == "" then [] else splitOn "," b
    rects = map (convRect) rawRects
    convRect s = conv $ map (\c -> read [c]) s
    conv [l,t,rw,rh] = (l,t,l+rw,t+rh)

makeField (w,h) = [(l,t,l+1,t+1) | l <- [0..w-1], t <- [0..h-1]]

insertRects :: Field -> [Rect] -> Field
insertRects field rects = foldl insertRect field rects ++ rects

insertRect :: Field -> Rect -> Field
insertRect field (l',t',r',b') = filter pred field
  where
    pred (l,t,r,b) = not $ l' <= l && r <= r' && t' <= t && b <= b'

initScores :: Field -> ScoreMap
initScores field = map go field
  where
    go rect@(0,0,r,b) = (rect,1)
    go rect = (rect,0)

calcScores :: ScoreMap -> ScoreMap
calcScores score = calcScores' (filter (\(_,s) -> s>0) score) (filter (\(_,s) -> s==0) score)

calcScores' :: ScoreMap -> ScoreMap -> ScoreMap
calcScores' calced [] = calced
calcScores' calced (n@(rect,score):ns) = case prepared ns rect of
  False -> calcScores' calced (ns++[n])
  True  -> calcScores' (calcScore calced rect:calced) ns

calcScore calced rect = (rect, score)
  where
    score = (`mod` 100) $ sum $ map snd $ findCells calced rect

-- 隣接するcell
prepared :: ScoreMap -> Rect -> Bool
prepared cell rect = length (findCells cell rect) == 0

findCells :: ScoreMap -> Rect -> ScoreMap
findCells m (l',t',r',b') = filter match m
  where
    match ((l,t,r,b),s) = left || top
      where
        left = (not $ b' <= t || b <= t') && r == l'
        top  = (not $ r' <= l || r <= l') && b == t'

-- 0,5,1,6 ! 0,2,2,5

-- 右下のcell
findResult :: (Int,Int) -> ScoreMap -> Int
findResult (w,h) scores = case find (\((l,t,r,b),s) -> w == r && h == b) scores of
  Nothing -> 0
  Just (r,s) -> s
