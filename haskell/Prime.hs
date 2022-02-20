import Data.Numbers.Primes


genPairList [] = []
genPairList [x] = []
genPairList (x:xs) = [(x,head xs)] ++ genPairList xs


primePairsMod6 n = genPairList $  map (\x -> x `rem` 6) $ take n primes

equalPairs l = toInteger $ length $ filter (\p -> (fst p) == (snd p)) l
unequalPairs l = toInteger $ length $ filter (\p -> (fst p) /= (snd p)) l

increased_likelihood n   = uneqPmod6/eqPmod6
   where 
   pl = primePairsMod6 n
   eqPmod6 = fromInteger $  equalPairs pl
   uneqPmod6 = fromInteger $ unequalPairs pl
