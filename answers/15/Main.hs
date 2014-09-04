import Data.List (lookup, transpose)
import Data.List.Split (splitOn)
import Control.Lens
import Numeric.Lens (base)

type Input = [String]

solve :: String -> String
solve = convert . parse



parse :: String -> Input
parse = transpose . map hex2bin . splitOn "/"

hex2bin :: String -> String
hex2bin input = tail $ dec ^. re (base 2)
    where (Just dec) = ("1" ++ input) ^? base 16



convert :: Input -> String
convert [] = []
convert ("00":is) = convert is
convert (a:b:c:is) | (Just char) <- lookup (a++b++c) pat3 = char : convert is
convert (a:b:is)   | (Just char) <- lookup (a++b) pat2 = char : convert is
convert _ = error "convert"

pat3, pat2 :: [(String,Char)]
pat3 = [("101110", 'T'), ("110111", 'U'), ("111011", 'N'), ("011110", 'S'), ("101101", 'Z')]
pat2 = [("1101", 'L'), ("1110", 'R'), ("0111", 'J')]
