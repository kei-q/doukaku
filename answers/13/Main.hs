-- !! ./record.sh
{-# LANGUAGE CPP #-}
module Main where

import Data.List
import Data.List.Split
import Debug.Trace
import Data.Char

import qualified TestData as TD

#ifdef DEBUG
(f # g) a = traceShow a $ g $ f a
#else
f # g = g . f
#endif

main :: IO ()
main = undefined

t :: Int -> IO ()
t = print . solve . fst . (TD.t!!)

solve :: String -> String
solve = solve' . parse

parse :: String -> [Int]
parse input = map (\c -> read [c]) input

solve' :: [Int] -> String
solve' input = show $ go1 [1] input

go1 :: [Int] -> [Int] -> Int
go1 [] _ = 0
go1 _ [] = 0
go1 (a:as) (x:xs)
  | x == 0 = go1 [1] xs
  | a <= x = go1 [x] xs
  | otherwise = go2 (x:a:as) xs

go2 :: [Int] -> [Int] -> Int
go2 [] _ = 0
go2 _ [] = 0
go2 (a:as) (x:xs)
  | x == 0 = go1 [1] xs
  | x <= a = go2 (x:a:as) xs
  | otherwise = traceShow (n,(x:as')) $ n + go2 (x:as') xs
  where (n,as') = sink x (a:as)

--sink :: Int -> [Int] -> [Int] -> (Int,[Int])
sink a (b:bs) = if null ys then (0,b:bs) else (max n 0, bs')
  where
    (xs,ys) = if any (>=a) bs then span (<a) (b:bs) else span (==b) (b:bs)
    n = sum $ map (\z -> x-z) xs
    bs' = replicate (length xs) x ++ ys
    x = min a (head ys)


--sink _ _ x [] = (0,[])
--sink a b [] (x:xs)
--  | b < x = undefined
--  | x <= b =
--  | x < a = let (n,xs') = sink a xs in (n+(a-x),a:xs')
--  | otherwise = (0,x:xs)

--4138
-- 4448
--314448
-- 334448



-- 8314 > 4
-- 844413
-- 844433 > 2
-- 84443310
-- 14516 > 4
-- 14556
-- 14556915 > 4
-- 1455695546 > 4
-- 14556966667 > 4
-- 14556977777
-- 14556977777112 > 2
-- 145569777772222

