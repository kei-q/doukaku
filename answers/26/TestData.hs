module TestData(tests) where

import Test.Hspec
import Solver (solve)

test (input, expected) = it input $ solve input `shouldBe` expected

tests = do {
test( "bdelmnouy", "5,7,9" );
test( "a", "1,1,1" );
test( "q", "1,1,1" );
test( "t", "1,1,1" );
test( "i", "1,1,1" );
test( "fg", "2,0,2" );
test( "gh", "0,2,2" );
test( "gm", "2,2,0" );
test( "fgh", "1,1,3" );
test( "fghm", "2,2,2" );
test( "fhm", "3,3,3" );
test( "bdfhjprx", "8,8,0" );
test( "abcdfghm", "4,4,0" );
test( "jklmqrst", "0,4,4" );
test( "klmntuvw", "4,0,4" );
test( "abcdefghijklmnopqrstuvwxy", "5,5,5" );
test( "abcdefghijklmnoqrtvwxy", "6,8,4" );
test( "abdefhijklnoprstvwxy", "10,8,4" );
test( "acegikmoqsuwy", "13,13,5" );
test( "bdfhjlnprtvxy", "13,11,1" );
test( "abdegijlnpqsuwy", "15,15,15" );
test( "aefghiqrstuvwxy", "3,3,15" );
test( "cfhkmoqrstuvwxy", "7,7,15" );
test( "cfhkmortvx", "10,10,10" );
test( "no", "0,2,2" );
test( "pwy", "3,3,3" );
test( "iqwy", "4,4,4" );
test( "lopuv", "3,3,5" );
test( "abdjtw", "6,6,6" );
test( "fgpstux", "5,3,5" );
test( "dijlnotv", "6,8,2" );
test( "bdefkmpwx", "5,9,3" );
test( "bfghjlmuwx", "4,8,6" );
test( "befghlopqrw", "5,7,9" );
test( "bfgjklmnqsux", "8,6,8" );
test( "fijklnpqstvwy", "9,9,9" );
test( "abcdfgilmnrsuv", "8,6,6" );
test( "abcdegijklnpruw", "11,11,9" );
test( "efgijkmnopqrtvwx", "6,8,4" );
test( "abcdefghilopqrtwy", "9,9,7" );
test( "abfghklmopqrsuvwxy", "8,6,12" );
test( "abcdeghklmoprstuwxy", "9,7,7" );
test( "abcdehijklmnopqrtwxy", "8,8,6" );
test( "acdefghimnopqrstuvwxy", "7,3,9" );
test( "abcfghijklmnopqrtuvwxy", "6,6,6" );
test( "abcdefghijklmnoqrstuwxy", "5,7,7" );
test( "abcdeghijklmnopqrstuvwxy", "6,6,6" );
}