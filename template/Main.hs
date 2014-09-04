
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
solve = "-"

parse :: a
parse = undefined

