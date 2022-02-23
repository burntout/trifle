#!/usr/bin/env python
from functools import *

'''
encode/decode strings to strings with binary
'''
binarify = lambda c: ' '.join(map(lambda x: format(x,"08b"), [ ord(d) for d in c]))
debinarify = lambda c: reduce( lambda x,y: x+y, map(lambda x: chr(int(x,2)), c.split()))

'''
fake multitap phone encode/decode
'''
phonify = lambda s: ' '.join([v for j in map(lambda x: [ str(['abc', 'def', 'ghi', 'jkl', 'mno', 'pqrs', 'tuv', 'wxyz'].index(i)+2) * (i.index(x) + 1 ) for i in ['abc', 'def', 'ghi', 'jkl', 'mno', 'pqrs', 'tuv', 'wxyz'] if x in i], s) for v in j])
dephonify = lambda m: ''.join([['abc', 'def', 'ghi', 'jkl', 'mno', 'pqrs', 'tuv', 'wxyz'][int(i[0])-2][len(i)-1] for i in m.split()])


''' 
function to calculate how many Mon,Tue,Wed,... Sun 
fell on a paticular dayofmonth in the gregorian calendar ( 400 years )
For example, is Friday 13th more common than other days
'''
import datetime
howmanyweekdays = lambda dayofmonth: [len(filter(lambda x: x==day, [datetime.date(year,month,dayofmonth).weekday() for year in range(2000,2400) for month in range(1,13)])) for day in range(0,7)]

'''
Calculate Reptend Primes for arbitrary base b
reptend primes base b, or the primes p, for which b is a primitive root for the group Zmodp

primes is a simple sieve of eratosthenes
reptend_primes finds all primes for which b is not a primitive root n by calculating b**i or where b is a multiple of p
and removes them from the list of primes.
'''
def primes(n):
    def sieve(r):
        return [] if r == [] else [r[0]] + sieve([e for e in r if e % r[0] != 0])
    return sieve(range(2,n))

def reptend_primes(n,b=10):
    return set(primes(n)) - set([p for p in primes(n) if [j for j in range(1,p-1) if pow(b, j, p) == 1] or b % p == 0])
