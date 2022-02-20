nextPrime x = x*(x-1) + 1

appendNextPrime ps = ps ++ [nextPrime p]
    where p = last ps

primes = iterate nextPrime 2

genPrimes = iterate appendNextPrime [2]
