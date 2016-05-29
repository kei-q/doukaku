import Data.Char
import Data.List

vertices [] = []
vertices ('0':'0':cs) =
  [(0, t) | t <- [0..39]] ++ [(0, t * 2 + 1) | t <- [0..19]] ++ vertices cs
vertices (c1:c2:cs) =
  [(r - dr, mod (t * 2 + r - 1 + dt) 40) | dr <- [0, 1], dt <- [0..2]] ++ vertices cs
  where
    r = ord c1 - ord '0'
    t = ord c2 - ord 'a'

solve = show.length.filter (==1).map length.group.sort.vertices

-- 以下テスト実施用コード

test input expected =
  if actual == expected
    then
      putStr "."
    else
      putStrLn $ concat
        [ "\ninput:    ", input
        , "\nexpected: ", expected
        , "\nactual:   ", actual
        ]
  where
    actual = solve input

main = do
  test "1a2t3s2s" "11"
  test "1a1c1d00" "22"
