-- decDigits x = floor $ 1 +  (log x) / (log 10)
-- decDigits :: Integer -> Integer
-- decDigits n = toInteger (round (logBase 10 (fromIntegral n)) + 1)
decDigits n = length $ show n

findK a n  = k
    where
        currentDecDigits = decDigits a
        k = (+) 1 $ length $ takeWhile (\x -> (1 + currentDecDigits) > decDigits x ) $ map (\x -> a + n^x) [1 .. ]

fooSeq = 1 : zipWith (\x y  -> x + y ^ (findK x y)) fooSeq [2 ..]


