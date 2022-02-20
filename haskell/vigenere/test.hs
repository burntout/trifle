import Data.List


indexSum a b = do 
    x <- elemIndex a alphabet
    y <- elemIndex b alphabet
    let idx = (x + y) `mod` (length alphabet)
    return $ alphabet!!idx
    where 
        alphabet = ['a' .. 'z']

