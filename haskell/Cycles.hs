import qualified Data.CircularList as CList
import Data.Numbers.Primes
import qualified Data.Set as Set

-- powm x y m = (x**y) `mod` m
powm' ::  Integer -> Integer -> Integer -> Integer -> Integer
powm' x 0 m r = r 
powm' x y m r 
    | y `mod` 2  == 0 = powm' (x * x `mod` m) (y `div` 2) m r 
    | otherwise       = powm' (x * x `mod` m) (y `div` 2) m (r * x `mod` m)


powm ::  Integer -> Integer -> Integer -> Integer
powm x y m = powm' x y m 1

-- cycles f [g] = [cs]
cycles f [] = [] 
cycles f gs = [CList.fromList loop] ++ (cycles f hs)
    where
        g = head gs 
        loop  = g : (takeWhile (/= g) $ tail $ iterate f g)
        hs = Set.toList ((Set.fromList gs) `Set.difference` (Set.fromList loop))
        
isAdditiveOrder m n g = n*g `mod` m == 0
        

