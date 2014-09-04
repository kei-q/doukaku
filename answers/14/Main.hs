import Data.Char

type Arms = String
type Enemies = String

solve :: String -> String
solve input = show $ tern (arms input) (enemies input)
  where
    arms = filter isLower
    enemies = filter isUpper

tern :: Arms -> Enemies -> Int
tern [] _ = 0
tern (a:as) es = killCount + tern as' es'
    where
        killCount = length $ filter (==x) es
        (Just x) = lookup a rules
        (Just a') = lookup x newArms
        as' = if killCount > 0 then (a':as) else as
        es' = filter (/=x) es

rules = zip "acegik" "BDFHJL"
newArms = zip "BDFHJL" "cegika"
