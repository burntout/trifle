-- Sums of three distinct positive cubes a^3 + b^3 + c^3 with a < b < c,
-- generated lazily in increasing order of the total.
--
-- The triples form a tree rooted at (1,2,3) in which every triple has
-- exactly one parent, and a child's total always exceeds its parent's:
--   (a,b,c) -> (a,b,c+1)                 always
--   (a,b,c) -> (a,b+1,c+1)               when c == b+1
--   (a,b,c) -> (a+1,a+2,a+3)             when b == a+1 and c == a+2
-- Repeatedly taking the smallest total from a frontier of such triples
-- (Data.Set as a priority queue) therefore enumerates every triple once,
-- in non-decreasing order of total.

import qualified Data.Set as Set

type Triple = (Integer, Integer, Integer)

cube :: Integer -> Integer
cube n = n * n * n

total :: Triple -> Integer
total (a, b, c) = cube a + cube b + cube c

children :: Triple -> [Triple]
children (a, b, c) =
    [(a, b, c + 1)]
    ++ [(a, b + 1, c + 1) | c == b + 1]
    ++ [(a + 1, a + 2, a + 3) | b == a + 1 && c == a + 2]

threeCubeSums :: [(Integer, Triple)]
threeCubeSums = go (Set.singleton (entry (1, 2, 3)))
  where
    entry t = (total t, t)
    go frontier = case Set.minView frontier of
        Nothing -> []
        Just (e@(_, t), rest) ->
            e : go (foldr (Set.insert . entry) rest (children t))

main :: IO ()
main = mapM_ display $ takeWhile ((<= 1230) . fst) threeCubeSums
  where
    display (s, (a, b, c)) =
        putStrLn $ show s ++ " = " ++ show a ++ "^3 + " ++ show b ++ "^3 + " ++ show c ++ "^3"
