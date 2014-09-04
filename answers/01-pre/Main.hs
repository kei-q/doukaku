import Data.List (sortBy, group, sort)

tests = [ "DASAD10CAHA"
        , "S10HAD10DAC10"
        , "S3S4H3D3DA"
        , "SASJDACJS10"
        , "CKH10D10H3HJ"
        , "S3SJDAC10SQ"
        ]

solve :: String -> String
solve = conv . sortBy (flip compare) . map length . group . sort . toR

conv :: [Int] -> String
conv (4:_)   = "4K"
conv (3:2:_) = "FH"
conv (3:_)   = "3K"
conv (2:2:_) = "2P"
conv (2:_)   = "1P"
conv _       = "--"

toR :: String -> [String]
toR [] = []
toR (_:c:ss) | c `elem` "JQKA" = [c] : toR ss
toR (_:ss) = let (n, rest) = head (reads ss) :: (Int, String) in show n : toR rest
