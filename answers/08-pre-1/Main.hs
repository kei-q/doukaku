{-# LANGUAGE NoImplicitPrelude #-}
module Main where

import BasicPrelude
import Numeric.Lens
import Control.Lens
import qualified Data.Text as T

solve :: String -> String
solve input = case conv (hex2bin input) of
    Nothing -> "*invalid*"
    Just (s,n) -> s ++ ":" ++ T.unpack (show n)

hex2bin :: String -> String
hex2bin s = reverse $ n ^. re (base 2)
  where (Just n) = reverse s ^? base 16 :: Maybe Int

conv :: String -> Maybe (String, Int)
conv = conv' ("",0)

conv' :: (String,Int) -> String -> Maybe (String,Int)
conv' (a,n) s
  | Just (b,c) <- find (\(b,_) -> b `isPrefixOf` s) code = conv' (c:a, n+length b) (drop (length b) s)
  | "111" `isPrefixOf` s = Just (reverse a,n+3)
  | otherwise = Nothing

code :: [(String, Char)]
code = [
    ("000",'t'),
    ("0010",'s'),
    ("0011",'n'),
    ("0100",'i'),
    ("01010",'d'),
    ("0101101",'c'),
    ("010111",'l'),
    ("0110",'o'),
    ("0111",'a'),
    ("10",'e'),
    ("1100",'r'),
    ("1101",'h')
    ]