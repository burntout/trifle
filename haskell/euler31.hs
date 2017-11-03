main::IO()
main  = do
    putStrLn $ generateOutput 200
    putStrLn $ generateOutput 400
    putStrLn $ generateOutput 600
    putStrLn $ generateOutput 800
    putStrLn $ generateOutput 1000

ways t (c:cs)
    | t == 0        = 1
    | cs == []      = 1
    | otherwise     = sum [ways (t - n*c) cs | n <- [0 .. (div t c)]]

generateOutput :: (Integer) -> [Char] 
generateOutput n = do 
    let w = show $ ways n [200,100,50,20,10,5,2,1]
    let num = show n
    let s = "Target " ++ num ++ ": "
    s ++ w


