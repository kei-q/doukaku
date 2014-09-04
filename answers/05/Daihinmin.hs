module Daihinmin where

import Data.Char
import Data.List
import Data.Function (on)
import qualified Data.String.Utils as SU
import Debug.Trace

type Cards = [Card]
data Card = Card Suit Rank | Joker deriving (Show, Eq)
data Suit = S | D | H | C deriving (Show, Read, Eq)
type Rank = Int
type Ranked = [Cards]
type Result = [Cards]
type Size = Int

run :: Input -> Output
run = showResult . solve . parse

getRank :: Card -> Rank
getRank (Card _ r) = r
getRank Joker = maxBound

solve :: (Base,Hand) -> Result
solve (yama,mycards) = solve' size rank mycards'
  where
    (size, rank) = getYamaInfo yama
    mycards' = injectJoker $ groupByRank mycards

solve' :: Size -> Rank -> Ranked -> Result
solve' size rank = makePattern . filterSize size . filterRank rank
  where
    makePattern = nub . concat . map (combination size)

combination :: Int -> [a] -> [[a]]
combination size = filter ((size==) . length) . subsequences

filterSize :: Size -> Ranked -> Ranked
filterSize size = filter ((size<=) . length)

filterRank :: Rank -> Ranked -> Ranked
filterRank rank = filter ((rank<) . getRank . head)

getYamaInfo :: Cards -> (Size, Rank)
getYamaInfo yama = (size, getRank rank)
  where
    size = length yama
    rank = minimumBy (compare `on` getRank) yama

groupByRank :: Cards -> Ranked
groupByRank = groupBy ((==) `on` getRank) . sortBy (compare `on` getRank)

injectJoker :: Ranked -> Ranked
injectJoker cards
  | hasJoker cards = injectJoker' cards
  | otherwise = cards
  where
    hasJoker = any ((==Joker) . head)
    -- 可能なら複数枚Joに対応したい
    injectJoker' = map aux
      where
        aux cards
          | head cards == Joker = cards
          | otherwise = cards ++ [Joker]

-----------------------------------------------------------
-- input parser
type Input = String
type Output = String
type Base = Cards
type Hand = Cards

parse :: Input -> (Base, Hand)
parse input = (toCards front, toCards back)
  where
    -- XXX: partial function
    [front, back] = SU.split "," input

toCards :: String -> Cards
toCards = map convCard . cut

-- 二文字ずつの文字列に分割
cut :: String -> [String]
cut [] = []
cut (_:[]) = []
cut s = take 2 s : cut (drop 2 s)

convCard :: String -> Card
convCard "Jo" = Joker
convCard (suitChar:rankChar:_) = Card (read [suitChar]) (cToRank rankChar)
convCard _ = error "convCard"

cToRank :: Char -> Rank
cToRank 'T' = 10
cToRank 'J' = 11
cToRank 'Q' = 12
cToRank 'K' = 13
cToRank 'A' = 14
cToRank '2' = 15
cToRank c = ord c - ord '0'

-----------------------------------------------------------
-- card 2 string
showResult :: Result -> String
showResult [] = "-"
showResult result = SU.join "," . map showCards $ result

showCards :: Cards -> String
showCards = SU.join "" . map fromCards

fromCards :: Card -> String
fromCards Joker = "Jo"
fromCards (Card suit rank) = show suit ++ [rankToC rank]

rankToC :: Rank -> Char
rankToC 10 = 'T'
rankToC 11 = 'J'
rankToC 12 = 'Q'
rankToC 13 = 'K'
rankToC 14 = 'A'
rankToC 15 = '2'
rankToC rank = chr (ord '0' + rank)
