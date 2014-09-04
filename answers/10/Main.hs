-- !! ./record.sh
module Main where

import Data.List

dataMap =
    [ "         "
    , "    TUVW "
    , "   kHIJX "
    , "  jSBCKY "
    , " iRGADLZ "
    , " hQFEMa  "
    , " gPONb   "
    , " fedc    "
    , "         "
    ]

dirs = [(-1,0), (-1,1), (0,1), (1,0), (1,-1), (0,-1)]

type Pos = (Int,Int)

solve :: String -> String
solve s = reverse $ snd $ foldl aux ((4,4), "A") s
  where
    aux (pos,ret) input = (pos', mark:ret)
      where
        dir = dirs !! read [input]
        (pos', mark) = move dir pos

move :: Pos -> Pos -> (Pos, Char)
move (dy,dx) pos@(py,px)
  | result == ' ' = (pos, '!')
  | otherwise = (pos', result)
  where
    pos'@(y,x) = (dy+py,dx+px)
    result = dataMap !! y !! x

