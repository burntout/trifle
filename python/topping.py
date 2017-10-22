#!/usr/bin/env python

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


