import Data.Char (ord)
import Data.List (elemIndex)

type Input = String
type Output = String

tests :: [(Input, Output)]
tests = [ ("b","AB"),
          ("l","AD"),
          ("r","AC"),
          ("bbb","ABAB"),
          ("rrr","ACBA"),
          ("blll","ABCAB"),
          ("llll","ADEBA"),
          ("rbrl","ACADE"),
          ("brrrr","ABEDAB"),
          ("llrrr","ADEFDE"),
          ("lrlll","ADFEDF"),
          ("lrrrr","ADFCAD"),
          ("rllll","ACFDAC"),
          ("blrrrr","ABCFEBC"),
          ("brllll","ABEFCBE"),
          ("bbbrrlrl","ABABEDFCB"),
          ("rbllrrrr","ACABCFEBC"),
          ("lbrlrrblr","ADABCFEFCA"),
          ("rlbrrrrbl","ACFCADFCFD"),
          ("bllrlrbrrb","ABCADEFEBCB"),
          ("rllrllllbb","ACFDEBADEDE"),
          ("blblrlrrlbr","ABCBEDFCABAC"),
          ("lrlrrrrrbrb","ADFEBCFEBEDE"),
          ("rblllrlrrlrr","ACABCADEFDABE"),
          ("rbrrlrblrllb","ACADFEBEFDACA"),
          ("lrrrlrllrrllr","ADFCABEFCADEBC"),
          ("rrlblllrrlrrb","ACBEBADEFDABEB"),
          ("brbllrrbbrlrll","ABEBADFCFCABEFC"),
          ("rrrbbrlbrlblrb","ACBABACFCABADFD"),
          ("lllllllllllblrr","ADEBADEBADEBEFDE"),
          ("llllllrllrlbrrr","ADEBADEFCBADABED")]

main = print $ filter (not . snd) $ zip [0..] (map test tests)
test (input, output) = solve input == output

road :: [(Char, String)]
road = [('A', "DCB"),
        ('B', "ACE"),
        ('C', "AFB"),
        ('D', "FAE"),
        ('E', "DBF"),
        ('F', "CDE")]

type Action = Char -> Char -> Char

solve :: Input -> Output
solve = solve' 'B' 'A' . map toAction

solve' :: Char -> Char -> [Action] -> Output
solve' _    cur [] = [cur]
solve' prev cur (action:cs) = cur : solve' cur (action prev cur) cs

toAction :: Char -> Action
toAction 'b' = turn (+0)
toAction 'l' = turn (+1)
toAction 'r' = turn (subtract 1) 
toAction _ = error "toAction"

turn :: (Int -> Int) -> Action
turn a prev cur = lst !! next
  where
    (_, lst) = road !! (ord cur - ord 'A')
    next = (a (j $ elemIndex prev lst) + len) `mod` len
    j (Just x) = x
    j _ = error "lookup"
    len = length lst
