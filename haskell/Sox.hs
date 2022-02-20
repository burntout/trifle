f n = n*(n-1)

ts = map f [1 .. ]

ws = map f [1 .. ]

ps = [p | p <- ws, 2 * p  `elem` ts]

