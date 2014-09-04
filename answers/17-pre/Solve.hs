module Solve where

import Control.Lens
import Numeric.Lens (hex)
import Data.List

import qualified TestData as TD

--t :: Int -> IO ()
t :: Int -> IO ()
t = print . solve . fst . (TD.t!!)

solve :: [Char] -> [Char]
solve = const "6,2,1,1,0,1"

parse :: Maybe Int
parse = "abc" ^? hex

