module Solver(solve) where

import Data.List
import Data.List.Split
import Control.Monad
import Data.Char

type Input = [Player]
type Output = [Int]

parse :: String -> Input
parse input = players
  where
    players = zip [1..] $ map parseHogemon $ splitOn "," input
    parseHogemon s = map convHogemon $ chunksOf 2 s

convHogemon :: String -> Hogemon
convHogemon (a:b:[]) = (n,n,b)
  where n = read [a]

format :: Output -> String
format = intercalate "," . map show

solve :: String -> String
solve input = format $ hoge $ parse input

data BRet = A Hogemon | B Hogemon | C

type Level = Int
type Kind = Char
type Life = Int
type Hogemon = (Level,Life,Kind)
type Player = (Int, [Hogemon])

hoge :: [Player] -> [Int]
hoge ps = map snd $ sort $ fuga ps

fuga :: [Player] -> [(Int,Int)]
fuga ps = zip (map (\p -> 0 - countWins p ps) ps) (map fst ps)

countWins :: Player -> [Player] -> Int
countWins a bs = length $ filter (battle (snd a)) $ map snd bs

battle :: [Hogemon] -> [Hogemon] -> Bool
battle [] [] = False
battle [] _ = False
battle _ [] = True
battle (a:as) (b:bs) = case battle' a b of
  A p -> battle (p:as) bs
  B p -> battle as (p:bs)
  C -> battle as bs

battle' :: Hogemon -> Hogemon -> BRet
battle' a@(alevel,alife,akind) b@(blevel,blife,bkind)
  | alevel == blevel = battle'a a b
  | alevel > blevel = battle'b a b
  | alevel < blevel = battle'c a b

battle'a :: Hogemon -> Hogemon -> BRet
battle'a a@(alevel,alife,akind) b@(blevel,blife,bkind)
  | alife' <= 0 && blife' <= 0 = C
  | alife' <= 0 = B (blevel, blife', bkind)
  | blife' <= 0 = A (alevel, alife', akind)
  | otherwise = battle'a (alevel, alife', akind) (blevel, blife', bkind)
  where
    alife' = alife - attack bkind akind
    blife' = blife - attack akind bkind

battle'b :: Hogemon -> Hogemon -> BRet
battle'b a@(alevel,alife,akind) b@(blevel,blife,bkind)
  | blife' <= 0 = A a
  | alife' <= 0 = B (blevel,blife',bkind)
  | otherwise = battle'b (alevel, alife', akind) (blevel, blife', bkind)
  where
    alife' = alife - attack bkind akind
    blife' = blife - attack akind bkind

battle'c :: Hogemon -> Hogemon -> BRet
battle'c a@(alevel,alife,akind) b@(blevel,blife,bkind)
  | alife' <= 0 = B b
  | blife' <= 0 = A (alevel,alife',akind)
  | otherwise = battle'c (alevel, alife', akind) (blevel, blife', bkind)
  where
    alife' = alife - attack bkind akind
    blife' = blife - attack akind bkind


attack :: Kind -> Kind -> Int
attack 'R' 'G' = 4
attack 'G' 'B' = 4
attack 'B' 'R' = 4
attack a b
  | a == b = 2
  | otherwise = 1
