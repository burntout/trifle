-- If a and b are relatively prime
-- then so is a*b + (b - a) (assuming b>a)
-- example relPrimes 3 5 gives the Fermat primes

relPrimes :: Integral a => a -> a -> [a]
relPrimes a b = (a: iterate (\x -> x*(x-d) + d) b)
    where d = b - a
