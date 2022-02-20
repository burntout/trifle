#!/usr/bin/env python3

import random
import string

def get_wordlist(wordfile="/usr/share/dict/words"):
    f =  open(wordfile, 'r')
    words=f.readlines()
    return list(set(w.strip().lower() for w in words))

def default_ranking(w):
    return sum([ord(l)-96 for l in w if l.isalpha()])

def alt_ranking(w): 
    return sum(map(lambda x: string.ascii_lowercase[::-1].index(x) + 1, [x.lower() for x in w if x in string.ascii_letters]))

def rank_words(wordlist, ranking=default_ranking):
    return sorted([(w, ranking(w)) for w in wordlist], key=lambda x: x[1])

def make_stupid(wordfile="/usr/share/dict/words",ranking=default_ranking, target=666):
    ranked_words=rank_words(get_wordlist(wordfile=wordfile),ranking=ranking)
    total=0
    out=[]
    while total <target:
        w,s = random.choice([word for word in ranked_words if word[1]<=target-total])
        if total + s <= target:
            total+=s
            out.append(w)
    random.shuffle(out)
    return (" ".join(out), total)

def add_stupid(word, wordfile="/usr/share/dict/words", ranking=default_ranking, target=666):
    new_target = target - ranking(word.lower())
    additional = make_stupid(wordfile=wordfile,target=new_target,ranking=ranking)
    return (word,ranking(word)) + additional

def main(ranking=default_ranking,target=666):
    print(make_stupid(ranking=default_ranking,target=666))

if __name__ == "__main__":
    main()



