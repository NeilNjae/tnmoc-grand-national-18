#!/usr/bin/python3

# Calculates the largest Fibonacci number in 15s.
# On my machine, calculates 1,174,787 terms

# Orignal example from https://docs.python.org/3/library/signal.html#example

import signal, os, math

def handler(signum, frame):
    print(math.log10(fibcurrent), fibn)
    raise ValueError('Finished')

fiblast = 0
fibcurrent = 1
fibn = 0

# Set the signal handler and a 15-second alarm
signal.signal(signal.SIGALRM, handler)
signal.alarm(15)

try:
    while True:
        fiblast, fibcurrent = fibcurrent, fiblast + fibcurrent
        fibn += 1
except ValueError:
    print('Finished', fibn)
    
signal.alarm(0)          # Disable the alarm
