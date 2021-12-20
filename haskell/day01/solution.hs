module Main (main) where

import Text.Printf (printf)

data TimesIncreased = TimesIncreased
  { previous :: Integer,
    timesIncreased :: Integer
  }
  deriving (Show)

countTimesIncreased :: TimesIncreased -> String -> TimesIncreased
countTimesIncreased TimesIncreased {previous = previous, timesIncreased = timesIncreased} currStr =
  TimesIncreased {previous = curr, timesIncreased = newTimesIncreased}
  where
    curr = read currStr :: Integer
    newTimesIncreased = if curr > previous then timesIncreased + 1 else timesIncreased

main :: IO ()
main = do
  _lines <- fmap lines (readFile "input.txt")
  print _lines
  printf "num lines: %d\n" (length _lines)
  print $ foldl countTimesIncreased (TimesIncreased {previous = 999999, timesIncreased = 0}) _lines
