{-# LANGUAGE BangPatterns #-}

-- Calculates the largest Fibonacci number in 15s.
-- On my machine, calculates 77,045,721 terms
-- Compile with `ghc -O3 timedfib.hs`

-- Original control structure from https://wiki.haskell.org/Timing_out_computations

import Control.Concurrent
import Control.Exception

type FibState = (Integer, Integer, Integer)

main :: IO ()
main = do 
    (_, ffib, n) <- timeoutIterate (15000000) fib (0, 1, 0) 
    print n

timeoutIterate usec f x = do
    mvar <- newMVar x
    let loop = do
        x <- takeMVar mvar
        evaluate (f x) >>= putMVar mvar
        loop
    thread <- forkIO loop
    threadDelay usec
    u <- takeMVar mvar
    killThread thread
    return u 

fib :: FibState -> FibState
fib !(old, new, count) = (new, old + new, count + 1)
