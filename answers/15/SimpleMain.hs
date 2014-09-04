import Data.List (lookup, transpose)
import Data.List.Split (splitOn)
import Control.Lens
import Numeric.Lens (base)

type Input = [String]

solve :: String -> String
solve = convert . parse

parse :: String -> Input
parse = transpose . map hex2bin . splitOn "/"

convert :: Input -> String
convert [] = []
convert ("00":is) = convert is
convert (a:b:[]) = [char]
    where Just char = pat2 a b
convert (a:b:c:is)
  | (Just char) <- pat3 a b c = char : convert is
  | (Just char) <- pat2 a b = char : convert (c:is)
  | otherwise = error "convert"

pat3 a b c = lookup (a++b++c) pat3table
pat3table = [("101110", 'T'), ("110111", 'U'), ("111011", 'N'), ("011110", 'S'), ("101101", 'Z')]
pat2 a b = lookup (a++b) pat2table
pat2table = [("1101", 'L'), ("1110", 'R'), ("0111", 'J')]

hex2bin :: String -> String
hex2bin input = tail $ dec ^. re (base 2)
    where (Just dec) = ("1" ++ input) ^? base 16
