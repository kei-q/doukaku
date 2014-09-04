-- !! ./record.sh
import Data.List.Split (splitOn, splitPlaces)
import Data.Bits (xor, testBit)
import Numeric (readHex)

solve :: String -> String
solve = foldl move ['0'..'8'] . map makeBridge . parse

parse :: String -> [Int]
parse = map (fst . head . readHex) . splitOn "-"

type Pos = Int

makeBridge :: Int -> [Pos]
makeBridge n = [i| i <- [0..8], testBit (n `xor` n*2) (8-i)]

move :: String -> [Pos] -> String
move v [] = v
move v (s:e:ss) = move (concat [a,c:bs,b:cs]) ss
  where [a,(b:bs),(c:cs)] = splitPlaces [s,e-s,9] v
