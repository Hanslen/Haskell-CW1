-- AE1FUN Course Work 1 (Started as Lab 4)
--

-- List, list patterns and recursion
--
-- DUE DATE: ||| Tuesday, March 24th 4pm |||
--
-- *** Work and submit in pairs. ***
--

-- --------------------------------------------------- --
-- Instructions (I will not look at your work if you do not strictly follow these steps):
--
-- 1) Work and submit in pairs (i.e. make one submission for two students).
-- 0) DO NOT SUBMIT THIS FILE but the file Cw1submit.hs 
-- 1) Fill in Cw1submit.hs by writing your Id, names 
--    and replacing the words "undefined -- answer in the submission file" by your answers
-- 2) Check that your file Cw1submit.hs works in Ghci
-- 3) Run it and produce the pictures (Activity 8) as a ps file.
-- 4) Zip both Cw1submit.hs AND the ps file into an archive named CW1.
-- 5) PRINT the first page of CW1submit.hs (your entire solution
--    should fit in one page) and the ps file resulting from Activity 8.
-- 6) Submit the 2 pages (.hs and .ps) as usual to FACULTY office before the deadline. 



import Prelude hiding (lines,unlines)

-- SECTION 1

-- ----------- --
-- Exercise 1  -- Complex pattern matching on lists, string manipulation
-- ----------- --

-- Define a function intersperse which insert an element BETWEEN all elements of a list. 

-- Examples:
-- intersperse 0   [1..5] = [1,0,2,0,3,0,4,0,5]
-- intersperse '.' "UNNC" = "U.N.N.C"
-- intersperse 4   []     = []
-- intersperse (*) [(+)]  = [(+)]

-- Use pattern matching and recursion on lists, the list constructors, but no other functions.
-- Write the type signature.

intersperse :: undefined -- answer in the submission file
intersperse = undefined  -- answer in the submission file


-- Use intersperse to define the function unlines which takes a list of strings and convert it into a single string 
-- with new line characters '\n' between the orignal strings.

-- Example:
-- unlines ["One string","on","each line"] = "One string\non\neach line"

-- Use only one equation in your definition.
-- Write the type signature.

unlines :: undefined -- answer in the submission file
unlines = undefined  -- answer in the submission file


-- ----------- --
-- Exercise 2  -- Complex pattern matching on lists
-- ----------- --

-- Define lines such that
--
--      unlines (lines s) = s           

-- for all strings s. That is, lines takes a string and returns the list of lines in that string, e.g.
--
--      lines "One string\non\neach line" = ["One string","on","each line"]
--
-- Use pattern matching and recursion on lists, the list constructors, but no other functions.

lines :: undefined  -- answer in the submission file
lines = undefined   -- answer in the submission file


-- ----------- --
-- Exercise 3  --
-- ----------- --
-- We view the type (Int,Int) as representing the set of points with integer coordinates.
-- Defining type synonyms using the command type allows us to convey more meaning in type signatures.

type Point   = (Int,Int)

-- Define a function 
next :: Point -> Point
-- which represents a bijection from the set of all points to the set of all points 
-- except the origin(0,0). In other words, each integer point of the plane should appear 
-- exactly once in the sequence (0,0),  next (0,0),  next(next(0,0)),  next(next(next(0,0))), ... 
-- (This sequence can be seen as a line, or path, which starts at (0,0) and goes through all points exactly once.)

next = undefined -- answer in the submission file


-- ----------- --
-- Exercise 4  -- (Difficult)
-- ----------- --
-- A path is a list of points which we take here as representing a continuous line joining all the points in the list,
-- in the order they appear in the list.
type Path    = [Point]

-- Use the function next to define an infinite path from the point (0,0) which passes through all points exactly once.
-- Use only one recursive equation to define points.
points :: Path
points = undefined -- answer in the submission file

-- ----------- --
-- Exercise 5  -- (Optional)
-- ----------- --
-- It is not possible to define equality on binary Haskell operators of type 
-- (Int -> Int -> Int) -> (Int -> Int -> Int) -> Bool
-- in general.
-- However, we can define a function (===) such that f === g returns False whenever we have the following
--      1. Both (f x y) and (g x y) terminate for all arguments x and y which terminate, and
--      2. There exists x and y such that f x y and g x y are not equal
-- If f and g are equal, g === f does not terminate.
-- We say that seperatedness (the property of being not equal) is SEMI-DECIDABLE.

-- Define (===) for the type Int -> Int -> Int
-- In particular, you should check that
-- (+) === (*) = False
-- (+) === (+) does not terminate 


-- SECTION 2

-- PostScript is, among other things, a page description language used by some printers and file formats such as PDF to describe 
-- the contents of pages to be printed. The purpose of the following exercises is to create very basic PostScript files 
-- to display some very simple drawings.


type PostScript      = String     -- Partial or complete PostScript programs.

postScriptFileName :: String
postScriptFileName = "page.ps"    -- The target PostScript file in which we save drawings (as PostScript programs).

-- render saves a PostScript program into the target file.
render :: PostScript -> IO()                -- IO stands for Inpout/Output. The result of this function is not a value but an IO ACTION (to write in a file).
render ps = writeFile postScriptFileName ps -- Writes the PostScript code ps in the file postScriptFileName

-- Here is an example of a PostScript program that draws a red square.
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
    
-- ----------- --
-- Activity 6  --
-- ----------- --
-- In your Haskell interactive interpreter, execute the command
--
-- render square
--
-- It should create a file "page.ps" in the current directory (the one in which this Haskell script is saved). 
-- Load the file in Notepad++ to check.
-- Now you can view display the page as it would be printed using gsview (see link on U drive). 
-- You can install gsview on your personal computer if it is not already install (it is free).

-- NOTE: in the sequel, you only need to press the R key to reload the file "page.ps" into gsview after each modification.




-- The purpose of the next two exercises is to define the functions grid and path 
-- that are used in the following definition.
cover :: Int -> PostScript
cover i = showpage (unlines 
                    [setgray 0.9   -- each element in this list is a bit of PostScript program
                    , grid
                    , setgray 0 
                    , path i])

-- Functions for basic postscript commands are defined further below.

-- ----------- --
-- Exercise 7  --
-- ----------- --

-- Use the function segment (see below) to define grid of lines 
-- crossing at integer points and each square in the grid has size 1x1.
-- You should draw about 25 vertical lines and 25 horizontal lines. 
-- Write your code in such a way that it is easy to change 25 to another number.
-- You can see the expected result in the povided file grid.ps, which was generated by running
--     render $ showpage grid
-- in GHCi.

grid :: PostScript
grid = undefined -- answer in the submission file
       
-- Use the functions newpath (see below) do define a path which goes through the  
-- i first points of the list  points  defined above. 
path :: Int -> PostScript
path = undefined -- answer in the submission file

-- ----------- --
-- Activity 8  --
-- ----------- --
-- Finally, display the result in gsview or other PS viewer. 
-- To do so, run the following main function in ghci. 
-- It should generate a PostScript file named page.ps, 
-- which you can view in gsview or any other PS viewer.

main :: IO()
main = render $ cover 200


-- END OF EXERCISES --

-- ------------------------- --
-- Basic PostScript commands --
-- ------------------------- --

-- The functions below constitute an example of a Domain Specific Language (see book, page 5 and 62) for writing PostScript program.

segment :: Point -> Point -> PostScript
segment p q = newpath [p,q]

newpath :: Path -> PostScript
newpath (p:ps) = unlines (["newpath",moveto p] ++ map lineto ps ++ ["stroke"])

-- !!! You do not need to use the functions below in the exercises !!!

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

