module Main where

import Data.List (intercalate)

-- 警告抑制のためのdummy
main :: IO ()
main = undefined

solve :: String -> String
solve = format . take 10 . foldl solve' [1..2000]

format :: [Int] -> String
format = intercalate "," . map show

solve' :: [Int] -> Char -> [Int]
solve' ns 'S' = removeNext ns isntSquare
solve' ns 's' = removePrev ns isntSquare
solve' ns 'C' = removeNext ns isntCube
solve' ns 'c' = removePrev ns isntCube
solve' ns 'h' = drop 100 ns
solve' ns c = remove ns (read [c])

remove :: [Int] -> Int -> [Int]
remove ns x = map fst $ filter (\(_,i) -> i`mod`x /= 0) $ zip ns [1..]

removePrev,removeNext :: [Int] -> (Int -> Bool) -> [Int]
removePrev ns pred = map fst $ filter (\(_,b) -> pred b) ns'
  where ns' = zip ns (tail ns)
removeNext ns pred = head ns : (map snd $ filter (\(a,_) -> pred a) ns')
  where ns' = zip ns (tail ns)

isntSquare, isntCube :: Int -> Bool
isntSquare n = let xs = map (\x -> x*x) (1:[2..n`div`2]) in n `notElem` xs
isntCube n = let xs = map (\x -> x*x*x) (1:[2..n`div`3]) in n `notElem` xs
