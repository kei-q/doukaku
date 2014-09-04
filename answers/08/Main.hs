module Main where

import Data.List.Split as LS
import Control.Lens
import Numeric.Lens
import Data.List

type Pos = (Int,Int)

solve :: String -> String
solve input = toS $ sumFire $ map (fire walls) bombs
    where
        (walls,bombs) = parse input

parse :: String -> ([Pos],[Pos])
parse input = (walls,bombs)
  where
    [f,b] = map hex2bin $ splitOn "/" input
    walls = bin2poss f
    bombs = bin2poss b

bin2poss s = ys'
  where
    ys = take 5 $ LS.chunk 6 s
    ys' = concatMap f $ zip [0..] ys
    f (n,ss) = zip [n,n..] $ toPos 0 ss

toPos n [] = []
toPos n ('1':ps) = n : toPos (n+1) ps
toPos n (_:ps) = toPos (n+1) ps

toS = concat . map bin2hex . LS.chunk 4 . toBin . normalize

toBin = toBin' 0
  where
    toBin' n [] = replicate (32 - n) '0'
    toBin' n (a:as)
        | n == a = '1' : toBin' (n+1) as
        | otherwise = '0' : toBin' (n+1) (a:as)

normalize = sort . map (\(y,x) -> y*6+x)

sumFire :: [[Pos]] -> [Pos]
sumFire = nub . concat

fire :: [Pos] -> Pos -> [Pos]
fire walls (by,bx) = ys ++ xs
  where
    ys = check (map snd $ filter (\(y,x) -> y == by) walls) (by,bx)
    xs = filter (\(y,x) -> y /= 5) $ map (\(x,y) -> (y,x)) $ check (map fst $ filter (\(y,x) -> x == bx) walls) (bx,by)

check ns b = nub $ checkL b ++ [b] ++ checkR b
  where
    checkL (a,-1) = []
    checkL (a,b) | b `elem` ns = []
    checkL (a,b) = checkL (a,b-1) ++ [(a,b)]
    checkR (a,6) = []
    checkR (a,b) | b `elem` ns = []
    checkR (a,b) = [(a,b)] ++ checkR (a,b+1)

hex2bin :: String -> String
hex2bin s = tail $ n ^. re (base 2)
  where (Just n) = ('1':s) ^? base 16 :: Maybe Int

bin2hex :: String -> String
bin2hex s = n ^. re (base 16)
  where (Just n) = s ^? base 2 :: Maybe Int

