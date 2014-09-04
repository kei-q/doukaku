import Control.Monad (guard)
import Data.List (sort)
import Data.Char (ord)

main = mapM_ (print . length . test) inputs

inputs = [ ""
         , "af"
         , "xy"
         , "pq qr rs st di in ns sx"
         , "af pq qr rs st di in ns sx"
         , "bg ch di ij no st"
         , "bc af ch di no kp mr ns ot pu rs"
         , "ab af"
         , "ty xy"
         , "bg ch ej gh lm lq mr ot rs sx"
         , "ty ch hi mn kp mr rs sx"
         , "xy ch hi mn kp mr rs sx"
         , "ch hi mn kp mr rs sx"
         , "ab cd uv wx"
         , "gh mn st lq qr"
         , "fg gl lm mr rs"
         ]

_MAPSIZE = 4

test input = walk (checker stops) [(0,0)]
  where
    stops = map (map char2pos) $ words input
    char2pos x = let n = ord x - ord 'a' in (n`div`5, n`mod`5)

checker stops n@(a,b) route@(prev:_) = and [isValidPos, isOpenRoute, isFirstTimeRoute]
  where
    isValidPos = 0 <= a && a <= _MAPSIZE && 0 <= b && b <= _MAPSIZE
    isOpenRoute = sort [n,prev] `notElem` stops
    isFirstTimeRoute = n `notElem` route

walk pred = walk' where
  walk' r = do
    routes <- [(-1,0),(0,1),(1,0),(0,-1)]
    let next = head r `add` routes
    guard $ pred next r
    if next == (_MAPSIZE, _MAPSIZE)
      then return 1
      else walk' (next : r)
    where (a,b) `add` (c,d) = (a+c,b+d)