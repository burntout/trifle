import Data.List

paths 1 = [[1]]
paths 2 = [[2],[1,1]]
paths n = end2 ++ end1
    where 
        end2   = [x ++ [2] |x <- paths (n-2) ]
        end1   = [x ++ [1] |x <- paths (n-1) ]
