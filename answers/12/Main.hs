solve :: String -> String
solve = map head . scanl move "162534"

move :: String -> Char -> String
move [f,b,s,n,e,w] c = case c of
  'N' -> [n,s, f,b, e,w]
  'S' -> [s,n, b,f, e,w]
  'E' -> [e,w, s,n, b,f]
  'W' -> [w,e, s,n, f,b]
move _ _ = error "move"