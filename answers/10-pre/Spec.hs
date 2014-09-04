module DoukakuSpec where

import Test.Hspec
import Control.Monad (forM_)
import Control.Applicative ((<$>))
import Main (solve)
import Data.List.Split

type Input = String
type Expected = String
type TestData = [[String]]

parse :: String -> TestData
parse = map aux . lines
  where
    aux = splitOn " "

main :: IO ()
main = do
  testdata <- parse <$> readFile "test.txt"
  hspec $
    describe "test" $
      forM_ testdata $ \[input, expected] ->
        it (input ++ " -> " ++ expected) $
          solve input `shouldBe` expected
