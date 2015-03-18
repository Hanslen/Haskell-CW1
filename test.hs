-- 2014-2015 AE1FUN Coursework 1
-- Student 1  ID:             NAME:
-- Student 2  ID:             NAME:

import Prelude hiding (lines,unlines)

intersperse :: a -> [a] -> [a]
intersperse x [] = []
intersperse x (y:[]) = [y]
intersperse x (y:ys) = [y] ++ [x] ++ (intersperse x ys) 

unlines :: [String] -> [String]
unlines xs = concat (intersperse "\n" xs)


lines :: String -> [String]
lines []        = []
lines ('\n':xs) = []:lines xs
lines [x]       = [[x]]
lines (x:xs)    = (x:y):ys where (y:ys) = lines xs