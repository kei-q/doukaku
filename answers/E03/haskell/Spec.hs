module DoukakuSpec where

-- import Test.Hspec
-- import Test.Hspec.Runner
-- import Test.Hspec.Formatters
-- import Control.Applicative
--
-- import Text.Parsec
--
-- import Control.Monad (forM_, unless)

import Control.Monad
import Main (solve)
import qualified TestData as TD

main :: IO ()
main = do
  forM_ (zip [0..] TD.t) $ \(n, (input, expected)) -> do
    let actual = solve input
    putStr (show n ++ " : ")
    case (actual == expected) of
      True -> putStrLn "ok"
      False -> putStrLn (actual ++ " != " ++ expected)

-- main :: IO ()
-- main = doukakuSpec $
--     forM_ (zip [1..] TD.t) $ \(n, (input, expected)) ->
--       it (show n) $
--         solve input `shouldBe` expected
--
-- doukakuSpec spec = do
--   hspecWith doukakuConfig spec
--   return ()
--
-- doukakuConfig = defaultConfig
--     { configFormatter = doukakuFormatter
--     , configColorMode = ColorAlways
--     }
--
-- doukakuFormatter :: Formatter
-- doukakuFormatter = silent {
--   exampleSucceeded = \_   -> withSuccessColor $ write "."
-- , exampleFailed    = \_ _ -> withFailColor    $ write "F"
-- , examplePending   = \_ _ -> withPendingColor $ write "."
-- , failedFormatter  = defaultFailedFormatter
-- }
--
-- defaultFailedFormatter :: FormatM ()
-- defaultFailedFormatter = getFailMessages >>= mapM_ formatFailure
--   where
--     formatFailure :: FailureRecord -> FormatM ()
--     formatFailure (FailureRecord path reason) = do
--       write (snd path ++ ") ")
--       withFailColor $ case reason of
--           Right _ -> do
--             unless (null err) $ do
--               writeLine $ parseReason err
--           Left _  -> do
--             write " (uncaught exception)\n"
--             unless (null err) $ do
--               writeLine err
--       where
--         err = either formatException id reason
--
--
-- parseReason :: String -> String
-- parseReason input =
--     case (parse reasonParser "" input) of
--         Left err -> show err
--         Right x -> x
--
-- reasonParser = do
--     expected <- string "expected: " *> str <* string "\n"
--     butgot <- string " but got: " *> str
--     return $ expected ++ " : " ++ butgot
--   where
--     str = char '"' *> many1 notDoubleQuote <* char '"'
--     notDoubleQuote = satisfy (/='"')
