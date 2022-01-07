#!/usr/bin/env python3

import string
import numpy as np

def normalize_word(word):
    return word.translate(str.maketrans('', '', string.punctuation)).lower()

def match_length(word,length=5):
    if len(word) == length and word[-2] == "'":  
        return False
    if len(word) == length: 
        return True
    return False

def get_words(wordlist='/usr/share/dict/words', length=5):
    wl = open(wordlist, 'r')
    all_words = [ normalize_word(w.strip()) for w in wl.readlines()]
    training_words = [word for word in all_words if len(word) == length]
    return list(set(training_words))

def filter_by_letter_place(wordlist, letter, place):
    return [word for word in wordlist if word[place] == letter]
    
def get_next_probability_dict(wordlist, cur_pos):
    out = dict()
    total = len(wordlist)
    for letter in string.ascii_lowercase:
        num = len(filter_by_letter_place(wordlist, letter, cur_pos+1))
        if total == 0 :
            out[letter] = 0
        else:
            out[letter] = num/total
    return out

def get_next_probability_list(wordlist, cur_pos):
    out = []
    total = len(wordlist)
    for letter in string.ascii_lowercase:
        num = len(filter_by_letter_place(wordlist, letter, cur_pos+1))
        if total == 0 :
            out.append(0)
        else:
            out.append(round(num/total,5))
    return bodge_factor(out)

def bodge_factor(l):
    bodge = round(1 - sum(l),5)
    m = max(l)
    i = l.index(m)
    l[i] = m + bodge
    return l

def get_transition_matrix(wordlist, cur_pos):
    transition_matrix=[]
    for letter in string.ascii_lowercase:
        letter_list = filter_by_letter_place(wordlist, letter, cur_pos)
        transition_matrix.append(get_next_probability_list(letter_list, cur_pos))
    return transition_matrix

def get_next_letter(wordlist, letter, position):
    letters = [a for a in string.ascii_lowercase]
    weights = get_transition_matrix(wordlist,position)[letters.index(letter)]
    next_letter = np.random.choice(letters,1,True,weights)[0]
    return next_letter

def invent_word(length=5):
    out = ""
    wordlist = get_words(length=length)
    letters = [a for a in string.ascii_lowercase]
    seed = np.random.choice(letters,1,True,get_next_probability_list(wordlist,-1))[0]
    out += seed
    for i in range(0,length-1):
        weights = get_transition_matrix(wordlist,i)[letters.index(seed)]
        seed = np.random.choice(letters,1,True,weights)[0]
        out += seed

    return "".join(out)
    
    
def main():
    new_word = invent_word(length=5)
    print(new_word)


if __name__ == "__main__":
    main()

