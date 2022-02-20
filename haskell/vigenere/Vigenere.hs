import Data.List

ct = "nyc tjpfrchy tgnins, ayi cetcocfh zo u wpcoliqyd, vcygtn ei tyavlcsn jr rxy 16kf afwuypo. ck gq b yppwqfgfycnuma scgfcs kfgykmv gr vbfw rmi fp kpaf ggfbvp ymyiezunj rm fwdvwfn kfc ejue. gd ikfcs fpvbi, nyc jfcuipi ce rff ejkcdyic ajyiip qlv qfjouib rs ugdgnsilj udmsoct, rmhgrjjz mprc kmzle b fpvb el gfpbbf eq jbv cldaztryie icz . dopgay kfc nxosybjyyzfcjg ayjycpt, yppwqfgfycnuma scgfcsb bvc dik qstlftryvcc rp osiokyeaw bwbpwicj, yq nxsi rxue mlf ufxrul zl rin qpyyhkcvu lbr zu lvnpfbfrrux sw y trokju fvrrfa jr rxy vlashqxgeh. kfc lnz mq jbv djbp."

known_pt = "thevigenerecipherwasinventedbyafrenchmanblaisedevigenereinthethcenturyitisapolyalphabeticcipherbecauseitusestwoormorecipheralphabetstoencryptthedatainotherwordsthelettersinthevigenerecipherareshiftedbydifferentamountsnormallydoneusingawordorphraseastheencryptionkeyunlikethemonoalphabeticcipherspolyalphabeticciphersarenotsusceptibletofrequencyanalysisasmorethanoneletterintheplaintextcanberepresentedbyasingleletterintheencryptionthekeyistheflag"

alphabet = "abcdefghijklmnopqrstuvwxyz"

key = "uryybjbeyq"
removeChar [] = []
removeChar (x:xs) 
    | elem x alphabet = x:(removeChar xs)
    | otherwise       = removeChar xs

myIndex a as = i
    where 
        Just i  = elemIndex a as


modify a b = alphabet!!n
    where 
        ai = myIndex a alphabet
        bi = myIndex b alphabet
        n = (ai - bi) `mod` (length alphabet)

modify' a b = alphabet!!n
    where 
        ai = myIndex a alphabet
        bi = myIndex b alphabet
        n = (ai + bi) `mod` (length alphabet)

encode modifyFunction key text = zipWith modifyFunction text (concat $ repeat key)
pt = encode modify key (removeChar ct)


