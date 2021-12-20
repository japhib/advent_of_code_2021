module Main where

import Control.Monad (forM_)
import Data.Foldable (find)
import Data.List (intercalate)
import Data.List.Split (splitOn)
import Data.Maybe (listToMaybe)
import Debug.Trace (trace)
import Text.Printf (printf)

boardSideLength :: Int
boardSideLength = 5

boardArea :: Int
boardArea = boardSideLength * boardSideLength

type BoardEntry = (Int, Bool)

type Board = [BoardEntry]

numsToBoardEntries :: [Int] -> [BoardEntry]
numsToBoardEntries = map (\num -> (num, False))

splitIntoBoards :: [Int] -> [Board]
splitIntoBoards [] = []
splitIntoBoards numbers =
  let (thisBoardNums, rest) = splitAt boardArea numbers
   in numsToBoardEntries thisBoardNums : splitIntoBoards rest

printBoardEntry :: BoardEntry -> String
printBoardEntry (number, False) = printf "%2d " number
printBoardEntry (number, True) = printf "\x1b[34m%2d\x1b[0m " number

printBoard :: Board -> IO ()
printBoard board = do
  forM_ [0 .. boardSideLength - 1] $ \i -> do
    forM_
      [0 .. boardSideLength - 1]
      ( \j ->
          printf "%s" $ printBoardEntry $ board !! (j + i * boardSideLength)
      )
    printf "\n"
  printf "\n"

applyNumberToBoard :: Int -> Board -> Board
applyNumberToBoard num =
  map
    (\(entryNum, status) -> if entryNum == num then (entryNum, True) else (entryNum, status))

anyHorizontalMatches :: [BoardEntry] -> Bool
anyHorizontalMatches board =
  any
    ( \i ->
        all
          ( \j ->
              snd $ board !! (j + i * boardSideLength)
          )
          [0 .. boardSideLength - 1]
    )
    [0 .. boardSideLength - 1]

anyVerticalMatches :: [BoardEntry] -> Bool
anyVerticalMatches board =
  any
    ( \i ->
        all
          ( \j ->
              snd $ board !! (i + j * boardSideLength)
          )
          [0 .. boardSideLength - 1]
    )
    [0 .. boardSideLength - 1]

anyMatches :: [Board] -> Maybe [BoardEntry]
anyMatches = find (\board -> anyHorizontalMatches board || anyVerticalMatches board)

printMatching :: Board -> Int -> IO ()
printMatching board lastNumber = do
  let sum =
        foldl
          ( \acc el ->
              acc
                + ( case el of
                      (n, True) -> 0
                      (n, False) -> n
                  )
          )
          0
          board
   in print (sum * lastNumber)

applyFirstNumberToBoards :: [Int] -> [Board] -> IO ()
applyFirstNumberToBoards [] _boards = putStrLn "No matches!"
applyFirstNumberToBoards (num : numbers) boards = do
  let boards' = map (applyNumberToBoard num) boards
  let matchingBoard = anyMatches boards'
   in do
        putStrLn $ " --- Number: " ++ show num
        putStrLn "boards now: "
        mapM_ printBoard boards'
        case matchingBoard of
          Nothing -> applyFirstNumberToBoards numbers boards'
          Just board -> printMatching board num

main :: IO ()
main = do
  _lines <- fmap lines (readFile "input.txt")
  print _lines
  let numbers_str = head _lines
  let numbers = map (\number_str -> read number_str :: Int) $ splitOn "," numbers_str
  let boards = splitIntoBoards $ map read $ words $ unwords $ tail _lines
   in do
        putStrLn "numbers!"
        print numbers
        putStrLn "baords!"
        mapM_ printBoard boards
        applyFirstNumberToBoards numbers boards
