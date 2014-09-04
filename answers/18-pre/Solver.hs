module Solver where

import Control.Monad (forM_) -- for tests

solve :: String -> String
--solve [] = []
--solve ('L':cs) = let x = solve cs; rx = rev x in concat [rx , "V" , x]
--solve ('J':cs) = let x = solve cs; rx = rev x in concat [x  , "V" , rx]
--solve ('Z':cs) = let x = solve cs; rx = rev x in concat [x  , "m" , rx  , "V" , x]
--solve ('U':cs) = let x = solve cs; rx = rev x in concat [rx , "V" , x   , "V" , rx]
--solve ('S':cs) = let x = solve cs; rx = rev x in concat [x  , "V" , rx  , "m" , x]

solve = foldr go []
  where
    go c x = case c of
      'L' -> concat [rx , "V" , x]
      'J' -> concat [x  , "V" , rx]
      'Z' -> concat [x  , "m" , rx  , "V" , x]
      'U' -> concat [rx , "V" , x   , "V" , rx]
      'S' -> concat [x  , "V" , rx  , "m" , x]
      where rx = rev x

rev :: String -> String
rev = reverse . map swap
  where
    swap 'V' = 'm'
    swap 'm' = 'V'

test :: IO ()
test = forM_ testdata $ \(input, expected) ->
    if solve input == expected
        then return ()
        else putStrLn $ "input: " ++ input ++ " expected: " ++ expected ++ " actual:" ++ solve input

testdata :: [(String,String)]
testdata =
    [( "JZ", "mVVmV" )
    ,( "J", "V" )
    ,( "L", "V" )
    ,( "Z", "mV" )
    ,( "U", "VV" )
    ,( "S", "Vm" )
    ,( "JL", "VVm" )
    ,( "JS", "VmVVm" )
    ,( "JU", "VVVmm" )
    ,( "LU", "mmVVV" )
    ,( "SL", "VVmmV" )
    ,( "SS", "VmVVmmVm" )
    ,( "SU", "VVVmmmVV" )
    ,( "SZ", "mVVmVmmV" )
    ,( "UL", "mVVVm" )
    ,( "UU", "mmVVVVmm" )
    ,( "UZ", "mVVmVVmV" )
    ,( "ZJ", "VmmVV" )
    ,( "ZS", "VmmVmVVm" )
    ,( "ZZ", "mVmmVVmV" )
    ,( "JJJ", "VVmVVmm" )
    ,( "JJZ", "mVVmVVmVmmV" )
    ,( "JSJ", "VVmmVVmVVmm" )
    ,( "JSS", "VmVVmmVmVVmVVmmVm" )
    ,( "JUS", "VmVVmVVmVVmmVmmVm" )
    ,( "JUU", "mmVVVVmmVVVmmmmVV" )
    ,( "JUZ", "mVVmVVmVVmVmmVmmV" )
    ,( "LJJ", "VmmVVVm" )
    ,( "LLS", "VmmVmVVmVVm" )
    ,( "LLU", "mmmVVVmmVVV" )
    ,( "LLZ", "mVmmVVmVVmV" )
    ,( "LSU", "mmVVVmmmVVVVmmmVV" )
    ,( "LSZ", "mVVmVmmVVmVVmVmmV" )
    ,( "LZL", "mmVVmVVmmVV" )
    ,( "LZS", "VmmVmVVmVVmmVmVVm" )
    ,( "LZU", "mmmVVVmmVVVmmmVVV" )
    ,( "SJL", "VVmVVmmmVVm" )
    ,( "SLU", "mmVVVVmmmVVmmmVVV" )
    ,( "SLZ", "mVVmVVmVmmVmmVVmV" )
    ,( "SSU", "VVVmmmVVVmmVVVmmmmVVVmmmVV" )
    ,( "SUJ", "mVVVmVVmmmVmmVVVm" )
    ,( "SUS", "VmVVmVVmVVmmVmmVmmVmVVmVVm" )
    ,( "SZZ", "mVmmVVmVVmVmmVVmVmmVmmVVmV" )
    ,( "UJJ", "VmmVVVmVVmm" )
    ,( "ULU", "mmmVVVmmVVVVmmmVV" )
    ,( "ULZ", "mVmmVVmVVmVVmVmmV" )
    ,( "UUU", "VVmmmmVVVmmVVVVmmVVVmmmmVV" )
    ,( "ZJU", "VVVmmmVVmmmVVVVmm" )
    ,( "ZLS", "VmVVmmVmmVmVVmVVm" )
    ,( "ZSJ", "VVmmVmmVVmmVVVmmV" )
    ,( "ZUJ", "mVVVmmVmmmVVmVVVm" )
    ,( "JJLJ", "mVVVmmVVmVVmmmV" )
    ,( "JLJJ", "VmmVVVmVVmmmVVm" )
    ,( "JLJL", "VmmVVVmVVmmmVVm" )
    ,( "LJJL", "VVmmVmmVVVmVVmm" )
    ,( "LLJJ", "VmmmVVmVVmmVVVm" )
    ,( "SZUS", "VmVVmVVmmVmmVmmVmVVmVVmVVmVVmmVmmVmmVmVVmVVmVVmmVmmVmmVmVVmVVmmVmmVmmVmVVmVVmVVm" )
    ,( "ULLS", "VmmVmmVmVVmVVmmVmVVmVVmVVmmVmmVmVVm" )
    ,( "JJJJZJ", "VmmVVVmmVVmVVmmVVmmmVVmVVmmVVVmmVVmmVmmVVmmmVVmVVmmVVVmmVVmVVmmVVmmmVVmmVmmVVVmmVVmmVmmVVmmmVVm" )
    ,( "JULLLJ", "mmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVVmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVmmmVmmVVmmmVVmVVmmmVmmVVVmmVVmVV" )
    ,( "LJJJUL", "mVVVmVVmmmVVmVVVmmVmmmVmmVVVmVVmmmVmmVVVmmVmmmVVmVVVmVVmmmVVmVVVmmVmmmVVmVVVmVVmmmVmmVVVmmVmmmV" )
    ,( "LJSJJL", "VVmVVmmVVVmmVmmmVVmVVmmmVVmmVmmVVVmVVmmmVVmmVmmVVVmVVmmVVVmmVmmmVVmVVmmVVVmmVmmVVVmVVmmmVVmmVmm" )
    ,( "LZLLLJ", "mmVmmVVmmmVVmVVmmmVmmVVVmmVVmVVVmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVVmmmVmmVVmmmVVmVVVmmVmmVVVmmVVmVV" )
    ,( "SJJJJL", "VVmVVmmVVVmmVmmVVVmVVmmmVVmmVmmVVVmVVmmVVVmmVmmmVVmVVmmmVVmmVmmmVVmVVmmVVVmmVmmVVVmVVmmmVVmmVmm" )
    ,( "ZLJLJL", "VmmVVVmmVmmmVVmVVmmVVVmVVmmmVVmmVmmVVVmmVmmmVVmmVmmVVVmVVmmmVVmVVmmVVVmmVmmmVVmVVmmVVVmVVmmmVVm" )
    ]