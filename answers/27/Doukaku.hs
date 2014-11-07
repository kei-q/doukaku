module Doukaku
    ( formatList
    , toBinary
    , module Text.Printf
    ) where

import Data.List (intercalate)
import Control.Lens
import Numeric.Lens
import Text.Printf

formatList :: (Show a) => String -> [a] -> String
formatList separator = intercalate separator . map show

toBinary :: Int -> String -> String
toBinary n input = tail $ (('1':input) ^?! base n) ^. re (base 2)
