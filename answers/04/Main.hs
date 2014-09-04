{-# LANGUAGE TupleSections, ViewPatterns #-}
import Data.List (nub, sort)
import Data.Maybe (fromMaybe)
import qualified Data.Map as M
import Test.HUnit

type Expected = Char
type Tetromino = [(Int, Int)]
type TestCase = (Tetromino,Expected)

main :: IO Counts
main = getContents >>= runTestTT . test . map ((\(a,b) -> solve a ~?= b) . parseInput) . lines

parseInput :: String -> TestCase
parseInput (words -> c:s) = (map convToPos s, head c)
  where convToPos t = read t `divMod` 10
parseInput _ = error "parseInput"

solve :: Tetromino -> Expected
solve = fromMaybe '-' . flip M.lookup table . adjust

adjust :: Tetromino -> Tetromino
adjust ps = sort $ map (\(x,y) -> (x-minx, y-miny)) ps
  where (minx,miny) = (fst $ minimum ps, minimum $ map snd ps)

spread :: Tetromino -> [Tetromino]
spread s = nub $ map adjust $ f s ++ f (mirror s)
  where f = take 4 . iterate rotate
        rotate = map (\(x,y) -> (y,-x))
        mirror = map (\(x,y) -> (-x,y))

table :: M.Map Tetromino Expected
table = M.fromList $ concatMap aux patterns
  where aux (pattern, output) = map (,output) $ spread pattern

patterns :: [TestCase]
patterns = [ ([(0,0),(0,1),(0,2),(1,0)],'L')
           , ([(0,0),(0,1),(0,2),(0,3)],'I')
           , ([(0,0),(0,1),(0,2),(1,1)],'T')
           , ([(0,0),(0,1),(1,0),(1,1)],'O')
           , ([(0,0),(0,1),(1,1),(1,2)],'S')
           ]
