#!/usr/bin/env stack
-- stack --resolver lts-12.21 script

{-# LANGUAGE BangPatterns #-}

import           Debug.Trace

add :: Int -> Int -> Int
add x y = x + y

add' :: Int -> Int -> Int
add' !x !y = x + y

addSeq :: Int -> Int -> Int
addSeq x y =
  let part1  = seq x part2
      part2  = seq y answer
      answer = x + y
  in  part1


main :: IO ()
main = do
  lazy
  strict
  verboseStrict


lazy :: IO ()
lazy = do
  let five  = add (1 + 1) (1 + 2)
      seven = add (1 + 2) (1 + 3)

  putStrLn $ "Five: " ++ show five

strict :: IO ()
strict = do
  let !five  = add' (1 + 1) (1 + 2)
      !seven = add' (1 + 2) (1 + 3)

  putStrLn $ "Five: " ++ show five

verboseStrict :: IO ()
verboseStrict = do
  let five  = addSeq (1 + 1) (1 + 2)
      seven = addSeq (1 + 2) (1 + 3)

  five `seq` seven `seq` putStrLn ("Five: " ++ show five)
