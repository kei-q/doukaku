module Main where

import Data.List
import Data.List.Split
import qualified Data.Map as M

solve :: String -> String
solve = showS . assign . normalize . parse

parse :: String -> [[String]]
parse = map (splitOn "_") . splitOn "|"

normalize :: [[String]] -> [(String,String)]
normalize = concat . transpose . map go
  where
    go [n,s] = map (\c -> (n,[c])) s

--assign :: [(String,String)] -> Map
assign = go M.empty
  where
    go m [] = m
    go m ((n,s):xs) = case M.lookup s m of
        Nothing -> go (M.insert s [n] m) clear
        Just ys
          | length ys < 4 -> go (M.update (\n' -> Just (n:n')) s m) clear
          | otherwise -> go m xs
      where clear = (filter (\(n',s') -> n/=n') xs)

showS :: M.Map String [String] -> String
showS m = intercalate "|" . map showS' . sort . M.toList $ m
  where
    showS' (n,ss) = n ++ "_" ++ intercalate ":" (map show $ sort $ map (read::String->Int) ss)