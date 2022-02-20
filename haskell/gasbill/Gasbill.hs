import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import Data.List
import Data.List.Split
import Data.Time

main = do
    textLines <- fmap Text.lines (Text.readFile "readings.txt")
    myDate <- getLine
    let strings = map Text.unpack textLines
        readings = map parseReading strings
        nightReadings = allMeterIDReading 1 readings
        dayReadings = allMeterIDReading 2 readings
        (startDate, endDate) = getReadingRange myDate readings
    -- putStrLn $ show $ getDays readings
    -- putStrLn $ show $ getReadingTotals readings
    putStrLn $ show $ getReadingRange "2020-01-01" readings
    putStrLn $ show (startDate, endDate)
    putStrLn $ show $ dateRateUsage startDate endDate readings
    


data MeterReading  = MeterReading { readingDate :: Day
                                  , meterID ::  Int
                                  , reading :: Integer
                                  } deriving (Eq, Ord, Show)

parseReading :: String -> MeterReading
parseReading s = MeterReading { readingDate = readingDate, meterID = meterID, reading = reading }
    where
    [dateString, meterIDString, readingString] = splitOn "," s
    [day, month, year] = splitOn "-" dateString
    readingDate = fromGregorian (read year :: Integer) (read month :: Int) (read day :: Int)
    meterID = read meterIDString :: Int
    reading = read readingString :: Integer

allMeterIDReading :: Int -> [MeterReading] -> [MeterReading]
allMeterIDReading  mtrid readings  = filter (\x -> meterID x == mtrid) readings

getDays :: [MeterReading] -> [Day]
getDays mrs = nub $ map readingDate $ sort mrs

getDayReadingTotal :: Day -> [MeterReading] -> Integer
getDayReadingTotal day mrs = sum $ map reading $ filter (\x -> readingDate x == day) mrs

getReadingTotals' :: [Day] -> [MeterReading] -> [Integer]
getReadingTotals' [] _ = []
getReadingTotals' days mrs = (getDayReadingTotal (head days) mrs) : (getReadingTotals' (tail days) mrs)

getReadingTotals :: [MeterReading] -> [MeterReading]
getReadingTotals mrs = zipWith (\x y -> MeterReading {readingDate = x, meterID = 3, reading = y}) days $ getReadingTotals' days mrs
    where
    days = getDays mrs

getReadingRange :: String -> [MeterReading] -> (Day, Day)
getReadingRange dateString mrs = getNearestRange date readingDates
    where 
    [day, month, year] = splitOn "-" dateString
    date = fromGregorian (read year :: Integer) (read month :: Int) (read day :: Int)
    readingDates = getDays mrs

getNearestRange :: Ord a => a -> [a] -> (a, a)
getNearestRange x xs
    | x <= head ys = (head ys, head $ tail ys)
    | x >= last ys = (last $ init ys, last ys)
    | (length $ filter (==x) ys) == 1 = (last $ takeWhile (<x) ys, x)
    | otherwise  = (last $ takeWhile (<x) ys, last $ takeWhile (>x) $ reverse ys)
    where ys = sort xs

getReadingsOnDay :: Day -> [MeterReading] -> [MeterReading]
getReadingsOnDay d mrs = filter (\x -> readingDate x == d) mrs

getTotalReadingsOnDay :: Day -> [MeterReading] -> Integer
getTotalReadingsOnDay d mrs = sum $ map reading $ getReadingsOnDay d mrs

dateRateUsage :: Fractional a => Day -> Day -> [MeterReading] -> a
dateRateUsage d1 d2 mrs = (fromIntegral (r2 - r1)) / (fromIntegral (diffDays d2 d1))
    where
    r1 = getTotalReadingsOnDay d1 mrs
    r2 = getTotalReadingsOnDay d2 mrs
