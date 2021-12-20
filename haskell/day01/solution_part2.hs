module Main (main) where

import Text.Printf (printf)

data TimesIncreased = TimesIncreased
  { previous :: [Integer],
    timesIncreased :: Integer
  }
  deriving (Show)

countTimesIncreased :: TimesIncreased -> String -> TimesIncreased
countTimesIncreased TimesIncreased {previous = [prev1, prev2, prev3], timesIncreased = timesIncreased} currStr =
  TimesIncreased {previous = [prev2, prev3, curr], timesIncreased = newTimesIncreased}
  where
    curr = read currStr :: Integer
    prev3Sum = prev1 + prev2 + prev3
    curr3Sum = prev2 + prev3 + curr
    newTimesIncreased = if curr3Sum > prev3Sum then timesIncreased + 1 else timesIncreased
countTimesIncreased TimesIncreased {previous = previous, timesIncreased = timesIncreased} currStr =
  TimesIncreased {previous = previous ++ [curr], timesIncreased = timesIncreased}
  where
    curr = read currStr :: Integer

main :: IO ()
main = do
  _lines <- fmap lines (readFile "input.txt")
  printf "num lines: %d\n" (length _lines)
  print $ foldl countTimesIncreased (TimesIncreased {previous = [], timesIncreased = 0}) _lines
