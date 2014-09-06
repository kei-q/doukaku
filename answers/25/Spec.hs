module DoukakuSpec where

import Test.Hspec
import Test.Hspec.Runner
import Test.Hspec.Formatters

import Text.Parsec

import Control.Monad (forM_, unless)
import Control.Applicative

import qualified TestData as TD

main :: IO ()
main = doukakuSpec TD.tests

doukakuSpec spec = do
  hspecWith doukakuConfig spec
  return ()

doukakuConfig = defaultConfig {
  configFormatter = silent { failedFormatter  = defaultFailedFormatter }
}

defaultFailedFormatter :: FormatM ()
defaultFailedFormatter = getFailMessages >>= mapM_ formatFailure
  where
    formatFailure :: FailureRecord -> FormatM ()
    formatFailure (FailureRecord path reason) = do
      write (snd path ++ " : ")
      let (a,b) = parseReason err
      withSuccessColor $ write a
      write " : "
      withFailColor $ write b
      writeLine ""
      where
        err = either (("uncaught exception" ++) . formatException) id reason

parseReason :: String -> (String, String)
parseReason input =
    case (parse reasonParser "" input) of
        Left err -> (show err, "")
        Right x -> x

reasonParser = do
    expected <- string "expected: " *> str <* string "\n"
    butgot <- string " but got: " *> str
    return $ (expected, butgot)
  where
    str = char '"' *> many1 notDoubleQuote <* char '"'
    notDoubleQuote = satisfy (/='"')
