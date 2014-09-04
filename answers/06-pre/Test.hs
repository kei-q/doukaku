{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
module Test where

import Test.Hspec
import BasicPrelude
import qualified Data.Text as T

import Main (solve)


type Input = Text
type Expected = Text
type TestData = [(Input, Expected)]

parse :: Text -> TestData
parse = map aux . lines
  where
    aux a = let (x,y) = separate a in (x,dropWS y)
    separate = T.span (/=' ')
    dropWS = T.dropWhile (==' ')

main :: IO ()
main = do
  testdata <- parse <$> readFile "test.txt"
  hspec $
    describe "test" $
      forM_ testdata $ \(input, expected) ->
        it (input ++ " -> " ++ expected) $
          show (solve input) `shouldBe` expected
