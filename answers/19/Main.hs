module Main where

import Data.List
import Data.List.Split

import qualified TestData as TD

main :: IO ()
main = mapM_ test TD.t

test (input,expected) = do
    let actual = solve input
    putStrLn $ if actual == expected
        then "o "
        else "x " ++ input ++ " :: " ++ actual ++ " : " ++ expected

solve :: String -> String
solve input = case ret of
    "" -> "none"
    s -> s
  where
    ret = intercalate "," $ map show $ answers \\ badsectors
    answers = map fst $ filter (\(tag,ns) -> length (ns `intersect` badsectors) > 1) disc
    badsectors = parse input
    disc = map hoge sectors
    sectors = [100..107] ++ [200..215] ++ [300..323] ++ [400..431]

parse :: String -> [Int]
parse = map read . splitOn ","

hoge n = (n, nub $ map snd $ filter (\(a,b) -> n == a) targets')
  where
    targets = links (edges 8 100) (edges 16 200) ++ links (edges 16 200) (edges 24 300) ++ links (edges 24 300) (edges 32 400)
    targets' = targets ++ links'' (edges 8 100) ++ links'' (edges 16 200) ++ links'' (edges 24 300) ++ links'' (edges 32 400)

edges :: Tag -> Tag -> [Edge]
edges n tag = [(tag+a, b, b + delta) | (a,b) <- zip ((cycle [0..n-1])::[Tag]) [start,(-start) .. (360-delta)]]
  where
    start = - delta / 2
    delta = 360 / toEnum n

type Tag = Int
type Edge = (Tag,Float,Float)
links :: [Edge] -> [Edge] -> [(Tag,Tag)]
links xs ys = concatMap (links' xs) (init ys)

links' :: [Edge] -> Edge -> [(Tag,Tag)]
links' xs (tag,e1,e2) = [(tag,tag1), (tag,tag2), (tag1,tag), (tag2,tag)]
  where
    (Just (tag1,_,_)) = find (search e1) xs
    (Just (tag2,_,_)) = find (search e2) xs
    search edge (_,start,end) = start < edge && edge < end

links'' xs = concat $ zipWith f xs (tail xs)
  where f (t1,_,_) (t2,_,_) = [(t1,t2), (t2,t1)]

