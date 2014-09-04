{-# LANGUAGE NoImplicitPrelude #-}
module Main where

import BasicPrelude

type Table = [String]

table :: Table
table = ["414213"
        ,"732050"
        ,"236067"
        ,"645751"
        ,"316624"
        ,"605551"
        ]

solve :: String -> String
solve = head . foldl (flip solve') table

solve' :: Char -> Table -> Table
solve' c
  | Just n <- c `elemIndex` "ABCDEF" = transpose . sortN n . transpose
  | Just n <- c `elemIndex` "uvwxyz" = sortN n
  where sortN n = sortBy (compare `on` (!!n))
solve' _ = error "solve'"
