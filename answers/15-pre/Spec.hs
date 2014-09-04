module DoukakuSpec where

import Test.Hspec
import Test.Hspec.Runner
import Test.Hspec.Formatters
import Data.List
import Control.Monad
import Data.Char
import Control.Applicative

import Text.Parsec
import Text.Parsec.String

import Control.Monad (forM_)

import Main (solve)
import qualified TestData as TD

main :: IO ()
main = do
  doukakuSpec $
    forM_ TD.t $ \(input, expected) ->
      it (input ++ " -> " ++ expected) $
        solve input `shouldBe` expected

doukakuSpec spec = do
  hspecWith doukakuConfig spec
  return ()

doukakuConfig = defaultConfig
    { configFormatter = doukakuFormatter
    , configColorMode = ColorAlway
    }

doukakuFormatter :: Formatter
doukakuFormatter = silent {
  exampleSucceeded = \_   -> withSuccessColor $ write "."
, exampleFailed    = \_ _ -> withFailColor    $ write "F"
, examplePending   = \_ _ -> withPendingColor $ write "."
, failedFormatter  = defaultFailedFormatter
}

defaultFailedFormatter :: FormatM ()
defaultFailedFormatter = do
  failures <- getFailMessages

  forM_ (zip [1..] failures) $ \x -> do
    formatFailure x
  where
    formatFailure :: (Int, FailureRecord) -> FormatM ()
    formatFailure (n, FailureRecord path reason) = do
      write (show n ++ ") ")
      withFailColor $ do
        case reason of
          Right _ -> do
            unless (null err) $ do
              writeLine $ parseReason err
          Left _  -> do
            write " (uncaught exception)\n"
            unless (null err) $ do
              writeLine err
      where
        err = either formatException id reason


parseReason :: String -> String
parseReason input =
    case (parse reasonParser "" input) of
        Left err -> show err
        Right x -> x

reasonParser = do
    expected <- string "expected: " *> str <* string "\n"
    butgot <- string " but got: " *> str
    return $ expected ++ " : " ++ butgot
  where
    str = char '"' *> many1 notDoubleQuote <* char '"'
    notDoubleQuote = satisfy (/='"')
