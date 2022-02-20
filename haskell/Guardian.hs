import Data.List


as = [1,3,7,9]
bs = [2,4,6,8]
cs = [1,3,7,9]
ds = [2,4,6,8]
es = [5]
fs = [2,4,6,8]
gs = [1,3,7,9]
hs = [2,4,6,8]
is = [1,3,7,9]
js = [0]


num [] = 1
num [x] = x
num xs = a + 10 * num bs
    where 
        a = last xs
        bs = init xs


unique :: (Eq a) => [a] -> Bool
unique []     = True
unique (x:xs) = x `notElem` xs && unique xs

solution  = [num [a,b,c,d,e,f,g,h,i,j] | a<-as,b<-bs,c<-cs,d<-ds,e<-es,f<-fs,g<-gs,h<-hs,i<-is,j<-js, unique [a,b,c,d,e,f,g,h,i,j]]
