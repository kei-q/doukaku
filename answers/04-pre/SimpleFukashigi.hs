import Control.Monad (guard)

type Route = [Pos]
type Pos = (Int,Int)

_MAPSIZE :: Int
_MAPSIZE = 4

test :: [Route]
test = walk [(0,0)]

walk :: Route -> [Route]
walk r = do
  routes <- [(-1,0),(0,1),(1,0),(0,-1)]
  let next = head r `add` routes
      route' = next : r
  guard $ pred' route'
  if next == (_MAPSIZE, _MAPSIZE)
    then return route'
    else walk route'
  where (a,b) `add` (c,d) = (a+c,b+d)

pred' :: Route -> Bool
pred' [] = False
pred' (n@(a,b):route) = isValidPos && isFirstTimeRoute
  where
    isValidPos = 0 <= a && a <= _MAPSIZE && 0 <= b && b <= _MAPSIZE
    isFirstTimeRoute = n `notElem` route
