successor a = a+1

predecessor a = predecessor' a 0 0
    where
    predecessor' a b prev 
        | a == 0 = 0
        | (successor b) == a = b
        | otherwise  = predecessor' a (successor b) b

add a b = add' a b a
    where
    add' a b c
        | b == 0 = c
        | otherwise = add' a (predecessor b) (successor c)

multiply a b = multiply' a b 0 
    where
    multiply' a b c 
        | b == 0  = c
        | otherwise  = multiply' a (predecessor b) (add a c)

exponentiate a b  = exponentiate' a b 1
    where    
    exponentiate' a b c
        | b == 0  = c
        | otherwise = exponentiate' a (predecessor b) (multiply a c)
