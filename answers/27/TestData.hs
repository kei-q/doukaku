module TestData(tests) where

import Test.Hspec
import Solver (solve)

test (input, expected) = it input $ solve input `shouldBe` expected

tests = do {
test( "befi", "14,16,24,26" );
test( "abc", "14,15,16,24,25,26,34,35,36" );
test( "de", "14,15,16,24,26,34,35,36" );
test( "fghi", "14,15,16,24,25,26,34,35,36" );
test( "abcdefghi", "-" );
test( "ag", "24,25,26,34,35,36" );
test( "dh", "14,15,16,34,35,36" );
test( "bf", "14,15,16,24,25,26" );
test( "ch", "15,25,35" );
test( "be", "14,16,24,26,34,36" );
test( "ci", "14,15,24,25,34,35" );
test( "cgi", "15,24,25,35" );
test( "acgi", "24,25,35" );
test( "cdefghi", "15,35" );
test( "acdefghi", "35" );
test( "cdegi", "15,24,35" );
test( "bcdegi", "24" );
test( "afh", "14,15,16,24,25,26,34,35,36" );
test( "abfh", "14,15,16,24,25,26" );
test( "dfh", "14,15,16,34,35,36" );
test( "cdfh", "15,35" );
test( "deh", "14,15,16,34,35,36" );
test( "cdeh", "15,35" );
test( "abefgh", "24,26" );
test( "abdefgh", "-" );
test( "acfghi", "25,35" );
test( "acdfghi", "35" );
test( "cegi", "15,24,35" );
test( "abcfhi", "15,25" );
test( "abcefhi", "-" );
test( "abdi", "14,15,16,24,34,35,36" );
test( "abdfi", "14,15,16,24" );
test( "bdi", "14,15,16,24,34,35,36" );
test( "bdfi", "14,15,16,24" );
test( "adfh", "14,15,16,34,35,36" );
test( "adfgh", "34,35,36" );
test( "acdfhi", "15,35" );
test( "bcdfgi", "24" );
test( "bcdfghi", "-" );
test( "defi", "14,15,16,24,34,35,36" );
test( "defhi", "14,15,16,34,35,36" );
test( "cdefg", "15,24,26,35" );
test( "cdefgi", "15,24,35" );
test( "bdefg", "24,26" );
test( "bdefgi", "24" );
}