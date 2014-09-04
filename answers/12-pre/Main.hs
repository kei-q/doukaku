import Numeric
import Data.List
import qualified Data.Array as A

hmap = (array A.!)
  where
    array = A.array ((0,0),(12,16)) $ concat [[((x,y),e), ((12-x,16-y),e)] | (y,s) <- zip [0..] raw, (x,e) <- zip [0..] s ]
    raw = [ "?????????????"
          , "?ABCDEFGHIJK?"
          , "?LMNOPQRSTUV?"
          , "?WXYZabcdefg?"
          , "?hij?????765?"
          , "?klm?????432?"
          , "?nop?????10z?"
          , "?qrs?????yxw?"
          , "?tuv?????vut?"]

solve = reverse . map hmap . fst . foldl exec ([(1,1)] , (1,0))

exec (route,dir) cmd
  | cmd == 'L' = (route, turn (+1) dir)
  | cmd == 'R' = (route, turn (+3) dir)
exec state cmd = move state (fst . head $ readHex [cmd])

move pos 0 = pos
move p@(r:_,_) _ | hmap r == '?' = p
move (r:rs,dir) n = move (add r dir : r : rs, dir) (n-1)
  where add (a,b) (c,d) = (a+c,b+d)

turn f dir = dirs !! (f idx `mod` length dirs)
  where (Just idx) = elemIndex dir dirs
        dirs = [(1,0),(0,-1),(-1,0),(0,1)]
