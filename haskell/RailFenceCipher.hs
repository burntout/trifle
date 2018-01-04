module RailFenceCipher (encode, decode) where

-- A rail fence cipher.
-- Implement encoding and decoding for the rail fence cipher.
-- 
-- The Rail Fence cipher is a form of transposition cipher that gets its name from
-- the way in which it's encoded. It was already used by the ancient Greeks.
-- 
-- In the Rail Fence cipher, the message is written downwards on successive "rails"
-- of an imaginary fence, then moving up when we get to the bottom (like a zig-zag).
-- Finally the message is then read off in rows.
-- 
-- For example, using three "rails" and the message "WE ARE DISCOVERED FLEE AT ONCE",
-- the cipherer writes out:
-- 
-- ```text
-- W . . . E . . . C . . . R . . . L . . . T . . . E
-- . E . R . D . S . O . E . E . F . E . A . O . C .
-- . . A . . . I . . . V . . . D . . . E . . . N . .
-- ```
-- 
-- Then reads off:
-- 
-- ```text
-- WECRLTEERDSOEEFEAOCAIVDEN
-- ```
 
-- the string corresponding 
-- to which rail they get placed on.
-- Sort the resultant tuple list by the labels, to get the cipher 

encode :: Int -> [a] -> [a]
encode n plain = map fst $ qs tuples 
      where 
          tuples = zip plain $ cycle $ [0 .. n-2] ++ [n-1, n-2 .. 1]

-- We generate a reverse key by simply encoding an list of ints
-- this is zipped with the cipher, and the resulting list of tuples 
-- sorted on that.

decode :: Int -> [a] -> [a]
decode n cipher = map fst $ qs tuples 
        where 
            tuples = zip cipher $ encode n [0 .. (length cipher)-1] 

-- A quick sort function on tuples
qs [] = []
qs [x] = [x]
qs (x:xs)  = qs(filter (\y->(snd y) < (snd x)) xs ) ++ [x] ++ qs( filter (\y->(snd y) >= (snd x)) xs )
