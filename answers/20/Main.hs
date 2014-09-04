module Main where

import Data.List
import Data.List.Split
import Text.Printf

import qualified TestData as TD

solve :: String -> String
solve input = ret
  where
    ts = parse input
    a1 = foldl subT z' (os ts)
    a2 = foldl subT z' (ws ts)
    z' = foldl subT (zs ts) [t1,t2]
    ret = case find (\(a,b) -> b-a>59) (sort (a1++a2)) of
      Just (a,b) -> showT (a,a+60)
      Nothing -> "-"
t1 = (convT "0000",convT "1000")
t2 = (convT "1800",convT "2359")
zs ts = sort $ map snd $ filter (\(p,_) -> p `elem` "Z") ts
os ts = sort $ map snd $ filter (\(p,_) -> p `elem` "ABI") ts
ws ts = sort $ map snd $ filter (\(p,_) -> p `elem` "ABJ") ts

type Person = Char
type Time = Int
type Range = (Time,Time)

showT :: (Int, Int) -> String
showT (a,b) = convS a ++ "-" ++ convS b

parse :: String -> [(Person,Range)]
parse input = map (\(c:t) -> (c, f t)) $ splitOn "," input
  where f t = let [a,b] = splitOn "-" t in (convT a, convT b)

convT :: String -> Int
convT ts = read h * 60  + read m
  where
    [h,m] = chunksOf 2 ts

convS :: Int -> String
convS t = let (h, m) = divMod t 60 in printf "%02d%02d" h m

subT :: [Range] -> Range -> [Range]
subT ts a = concatMap (flip subT' a) ts

subT' :: Range -> Range -> [Range]
subT' (a,b) (c,d)
  | a <= c && d <= b = [(a,c),(d,b)]
  | c <= a && b <= d = []
  | a <= c && c <= b = [(a,c)]
  | a <= d && d <= b = [(d,b)]
  | otherwise = [(a,b)]

compact [] = []
compact (a:[]) = [a]
compact ((a1,b1):(a2,b2):as)
  | b1+1 == a2 = compact ((a1,b2):as)
  | otherwise = (a1,b1) : compact ((a2,b2):as)






{- めも
鍋谷さんの解説中に完成
[0000..2359]は負けた気持ちになる
+1と-1を勘違い
17:00-18:00の会議は61分の会議
条件忘れ

-}