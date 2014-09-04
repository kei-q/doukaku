module Main where

import Data.List (intercalate)

solve :: String -> String
solve = intercalate "," . map show . take 10 . foldl solve' [1..]

solve' :: [Int] -> Char -> [Int]
solve' ns 'S' = removeNext ns (check 2)
solve' ns 's' = removePrev ns (check 2)
solve' ns 'C' = removeNext ns (check 3)
solve' ns 'c' = removePrev ns (check 3)
solve' ns 'h' = drop 100 ns
solve' ns c = remove ns (read [c])

remove :: [Int] -> Int -> [Int]
remove ns x = map fst $ filter (\(_,i) -> i`mod`x /= 0) $ zip ns [1..]

removePrev,removeNext :: [Int] -> (Int -> Bool) -> [Int]
removePrev ns pred = map fst $ filter (pred . snd) $ zip ns (tail ns)
removeNext ns pred = (head ns :) . map snd . filter (pred . fst) $ zip ns (tail ns)

check :: Float -> Int -> Bool
check e n = round (toEnum n ** (1/e)) ^ fromEnum e /= n