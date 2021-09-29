relPrimes :: Integral a => a -> a -> [a]
relPrimes a b = (a: iterate (\x -> x*(x-d) + d) b)
    where d = b - a
