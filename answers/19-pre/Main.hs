module Main where

import Data.List (intercalate, union, sort, nub)
import Data.List.Split (splitOn)

solve :: String -> String
solve = solve' . map read . splitOn ","

solve' :: [Int] -> String
solve' sample = case foldl1 uni (map mkPat sample) of
    [] -> "none"
    [answer] -> intercalate "," $ map show answer
    _ -> "many"

uni :: [[Int]] -> [[Int]] -> [[Int]]
uni a b = nub [sort pat| x<-a,y<-b, let pat = x`union`y, length pat <= 3]

mkPat :: Int -> [[Int]]
mkPat n = [n] : pat3 ++ pat2
  where
    pat3 = [nub [x,y,z]| x<-[1..n], y<-[x..n], z<-[y..n], x+y+z==n]
    pat2 = [nub [x,y]| x<-[1..n], y<-[x..n], x+y==n]

main :: IO ()
main = do
  test "3,11,12,102,111,120" "1,10,100"
  test "10,20,30,35,70" "many"
  test "1,5,20,80" "none"
  test "1,2,3,4,5,6,7,8,9,10,11,12,13,14" "many"
  test "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" "1,4,5"
  test "1,2,3,4,5,6,7,8,9,10,11,12,13,14,17" "none"
  test "1,2,3,4,5,6,7,8,9,10,11,12,13,14,18" "1,4,6"
  test "5,6,7,8,9,10,11,12,13,14,15,16" "2,5,6"
  test "9,10,11,12,13,14,15,16,17,18,19" "4,5,7"
  test "11,36,37,45,55,70,71" "1,10,35"
  test "92,93,94,95,96,97,98,99" "30,32,33"
  test "95,96,97,98,99,100" "many"
  test "27,30,34,37,43,44,46,51,57" "10,17,23"
  test "6,10,13,17,65,73,76,80" "none"
  test "12,19,21,29,85" "none"
  test "1,2,8,10,14,23,58,62,64" "none"
  test "4,22,25,31,44,50,58,69,71,72,73,77" "none"
  test "8,16,26,27,42,53,65,69,81,83,88,99" "none"
  test "9,10,23,24,28,33,38,39,58,68,84" "none"
  test "11,16,24,26,88" "none"
  test "24,33,47,56,63,66,75,78,89,93" "none"
  test "7,26,72,77" "many"
  test "69,88,95,97" "many"
  test "9,14,48,89" "many"
  test "69,76,77,83" "many"
  test "11,14,24" "many"
  test "8,25,75,93" "many"
  test "11,55,93,98,99" "many"
  test "71,83,87" "many"
  test "22,76,77,92" "7,15,62"
  test "33,61,66,83,95" "17,33,61"
  test "6,16,49,55,72" "6,16,33"
  test "62,85,97,98" "12,25,73"
  test "54,60,67,70,72" "20,25,27"
  test "54,61,68,84,87" "27,30,34"
  test "65,67,69,75,79,89,99" "21,23,33"
  test "69,72,80,81,89" "23,24,33"
  test "1,2,3" "many"

test :: String -> String -> IO ()
test input expected = do
    let actual = solve input
    putStrLn $ if actual == expected
        then "o " ++ input ++ " : " ++ expected
        else "    x " ++ input ++ " : " ++ expected ++ " : " ++ actual
