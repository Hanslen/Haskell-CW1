-- 2014-2015 AE1FUN Coursework 1
-- Student 1  ID:             NAME:
-- Student 2  ID:             NAME:

import Prelude hiding (lines,unlines)

intersperse :: a -> [a] -> [a]
intersperse x [] = []
intersperse x (y:[]) = [y]
intersperse x (y:ys) = [y] ++ [x] ++ (intersperse x ys) 

unlines :: [String] -> String
unlines xs = [m|n<-(intersperse "\n" xs),m<-n]


lines :: String -> [String]
lines []        = [[]]
lines [x]       = [[x]]
lines (x:xs)    = (x:y):ys where (y:ys) = lines xs

next :: Point -> Point
next (a,b) | (a == 0 && b == 0 ) = (1,0)
           | a + b > 0 && a - 1 >= b = (a,b - 1)
           | a + b < 0 && a <= b = (a,b + 1)
           | a + b <= 0 && a > b = (a - 1,b)
           | otherwise           = (a + 1,b)

points :: Path
points = [(0,0)] ++ map next points


(===) :: (Int -> Int -> Int) -> (Int -> Int -> Int) -> Bool
(===) a b = (map (uncurry a) points) == (map (uncurry b) points) 

grid :: PostScript
grid = segment (0,0) (0,lengthlong) ++"\n" ++ help1 1 where help1 n | n == lengthlong = segment(n, 0) (n, lengthlong) ++ "\n" ++ help2 0
                                                                    | otherwise = segment(n,0) (n, lengthlong) ++ "\n" ++ help1 (n+1)
                                                            help2 m | m == lengthlong = segment(0,m) (lengthlong, m)
                                                                    | otherwise = segment(0,m) (lengthlong, m) ++ "\n" ++ help2 (m+1)
                                                            lengthlong = 25

path :: Int -> PostScript
path i = newpath (take i points)
-- END OF SUBMISSION, DO NOT PRINT WHAT FOLLOWS WHEN SUBMITTING TO FACULTY OFFICE.
-- (BUT DO KEEP EVERYTHING WHEN SUBMITTING IN MOODLE)

main :: IO()
main = render $ cover 200
         
type Point   = (Int,Int)
type PostScript      = String
type Path    = [Point]

postScriptFileName :: String
postScriptFileName = "page.ps"

render :: PostScript -> IO()                
render ps = writeFile postScriptFileName ps 


square :: PostScript
square = unlines
    ["%!"
    ,"1 0 0 setrgbcolor"
    ,"newpath"
    ,"344 344 moveto"
    ,"144 0 rlineto"
    ,"0 144 rlineto"
    ,"-144 0 rlineto"
    ,"closepath"
    ,"fill"
    ,"0 setgray"
    ,"newpath"
    ,"344 344 moveto"
    ,"144 0 rlineto"
    ,"0 144 rlineto"
    ,"-144 0 rlineto"
    ,"closepath"
    ,"stroke"
    ,"showpage"]
    

cover :: Int -> PostScript
cover i = showpage (unlines 
                    [setgray 0.9 
                    , grid
                    , setgray 0 
                    , path i])
                    
segment :: Point -> Point -> PostScript
segment p q = newpath [p,q]

newpath :: Path -> PostScript
newpath (p:ps) = unlines (["newpath",moveto p] ++ map lineto ps ++ ["stroke"])

scale :: Point -> Point
scale (x,y) = (300 + 10 * x,480 + 10 * y)

showPoint :: Point -> PostScript
showPoint p = show x ++ " " ++ show y
                where
                (x,y) = scale p
            
lineto :: Point -> PostScript
lineto p = showPoint p ++ " lineto"  

moveto :: Point -> PostScript
moveto p = showPoint p ++ " moveto"

showpage :: PostScript -> PostScript
showpage ps = unlines ["%!",ps,"showpage"]

setgray :: Float -> PostScript
setgray r = show r ++ " setgray"