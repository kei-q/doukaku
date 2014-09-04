import Numeric (showIntAtBase, readInt)
import Data.Char (intToDigit, digitToInt)

tests =
  [ ("3:5b8"                   , "3:de0")
  , ("1:8"                     , "1:8")
  , ("2:8"                     , "2:4")
  , ("2:4"                     , "2:1")
  , ("2:1"                     , "2:2")
  , ("3:5d0"                   , "3:5d0")
  , ("4:1234"                  , "4:0865")
  , ("5:22a2a20"               , "5:22a2a20")
  , ("5:1234567"               , "5:25b0540")
  , ("6:123456789"             , "6:09cc196a6")
  , ("7:123456789abcd"         , "7:f1a206734b258")
  , ("7:fffffffffffff"         , "7:ffffffffffff8")
  , ("7:fdfbf7efdfbf0"         , "7:ffffffffffc00")
  , ("8:123456789abcdef1"      , "8:f0ccaaff78665580")
  , ("9:112233445566778899aab" , "9:b23da9011d22daf005d40")
  ]

main :: IO ()
main = print $ filter (\(test, expected) -> solve test /= expected) tests

solve :: String -> String
solve s = let (size, bitmap) = span (/=':') s
              n = read size
         in show n ++ ":" ++ rotate n (tail bitmap)

-- `tail . conv 2 16 . ('1':)`
-- 上記は先頭の'0'が消えないようにするためのコード
rotate :: Int -> String -> String
rotate n = tail . conv 2 16 . ('1':) . convert . bits' . conv 16 2
  where
    convert = (++ zeros (n*n)) . concat . foldl (\(s:ss) c -> ss ++ [c:s]) (replicate n "")
    bits' bits = take (n*n) $ zeros (length bits) ++ bits
    zeros x = if mod x 4 == 0 then "" else drop (mod x 4) "0000"

conv :: Integer -> Integer -> String -> String
conv from to = toString to . toDecimal from
  where toString base n = showIntAtBase base intToDigit n ""
        toDecimal base = fst . head . readInt base (const True) digitToInt
