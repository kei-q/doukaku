module Main(main) where

import Test.Hspec
import Control.Monad (forM_)

import Solver (solve)
import qualified TestData as TD

main :: IO ()
main = do
  hspec $
    describe "test" $
      forM_ TD.t $ \(input, expected) ->
        it (input ++ " -> " ++ expected) $
          solve input `shouldBe` expected
