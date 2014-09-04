module Test where

import Test.Hspec
import Control.Monad (forM_)
import Control.Applicative ((<$>))
import Main (solve)

type Input = String
type Expected = String
type TestData = [(Input, Expected)]

parse :: String -> TestData
parse = map aux . lines
  where
    aux a = let (x,y) = separate a in (x,dropWS y)
    separate = span (/='\t')
    dropWS = dropWhile (=='\t')

main :: IO ()
main = do
  testdata <- parse <$> readFile "test.txt"
  hspec $
    describe "test" $
      forM_ testdata $ \(input, expected) ->
        it (input ++ " -> " ++ expected) $
          solve input `shouldBe` expected
