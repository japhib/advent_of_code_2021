module Main (main) where

import Text.Printf

riskMap =
  [1, 1, 6, 3, 7, 5, 1, 7, 4, 2]
    ++ [1, 3, 8, 1, 3, 7, 3, 6, 7, 2]
    ++ [2, 1, 3, 6, 5, 1, 1, 3, 2, 8]
    ++ [3, 6, 9, 4, 9, 3, 1, 5, 6, 9]
    ++ [7, 4, 6, 3, 4, 1, 7, 1, 1, 1]
    ++ [1, 3, 1, 9, 1, 2, 8, 1, 3, 7]
    ++ [1, 3, 5, 9, 9, 1, 2, 4, 2, 1]
    ++ [3, 1, 2, 5, 4, 2, 1, 6, 3, 9]
    ++ [1, 2, 9, 3, 1, 3, 8, 5, 2, 1]
    ++ [2, 3, 1, 1, 9, 4, 4, 5, 8, 1]

printPos :: (Integer, Integer) -> String
printPos (currX, currY) = printf "(%d, %d)" currX currY

possibleNewPositions :: (Integer, Integer) -> [(Integer, Integer)]

possibleNewPositions

mainRecursive :: (Integer, Integer) -> Integer -> IO ()
mainRecursive currPos total =
  -- Print current position
  printf "position: %s, total: %d\n" $ printPos currPos

main :: IO ()
main =
  let currPos = (0, 0) :: (Integer, Integer)
   in mainRecursive currPos 0