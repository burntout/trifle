#!/usr/bin/env python3

from math import ceil
from fractions in Fraction

def egypt(fraction):
    ''' takes in input fraction and outputs a list of fractions in egyptian form that sum to the input
    Uses Leonardo de Pisa's method
    The egyptian form is not unique
    e.g 21/32 = 1/2 + 1/8 + 1/32
    and 21/32 = 1/2 + 1/7 + 1/75 + 1/16800
    '''
    x=fraction.numerator
    y=fraction.denominator
    if (-y % x) == 0: return [Fraction(1, y//x)]
    return [Fraction(1,ceil(y/x))] + egypt(Fraction(-y%x, y*ceil(y/x)))

