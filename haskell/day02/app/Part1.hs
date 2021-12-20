module Part1 (doMain) where

import Data.List.Split (splitOn)

data CurrPosData = CurrPosData {depth :: Integer, horizontal :: Integer} deriving (Show)

determinePos :: CurrPosData -> String -> CurrPosData
determinePos currPosData currStr =
  case command of
    "forward" -> currPosData {horizontal = _horizontal + num}
    "up" -> currPosData {depth = _depth - num}
    "down" -> currPosData {depth = _depth + num}
    _ -> currPosData
  where
    _depth = depth currPosData
    _horizontal = horizontal currPosData
    [command, numberStr] = splitOn " " currStr
    num = read numberStr :: Integer

doMain :: IO ()
doMain = do
  _lines <- fmap lines (readFile "input.txt")
  print $ foldl determinePos (CurrPosData {depth = 0, horizontal = 0}) _lines