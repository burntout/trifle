add a b 
    | a == 0  = b
    | otherwise = succ $ add (a-1) b
