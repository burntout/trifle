#!/usr/bin/env python3

import string
import numpy as np

def normalize_word(word):
    return word.translate(str.maketrans('', '', string.punctuation)).lower()

def get_words(wordlist='/usr/share/dict/words', length=5):
    wl = open(wordlist, 'r')
    all_words = [ normalize_word(w.strip()) for w in wl.readlines()]
    training_words = [word for word in all_words if len(word) == length]
    return list(set(training_words))

def get_words_with_constraint(wordlist='/usr/share/dict/words', length=5, includes="", excludes="",positions={}):
    wl = open(wordlist, 'r')
    all_words = [ normalize_word(w.strip()) for w in wl.readlines()]
    training_words = [word for word in all_words if len(word) == length]
    for c in includes:
        training_words = [word for word in training_words if c in word]
    for c in excludes:
        training_words = [word for word in training_words if c not in word]
    for pos,c in positions.items():
        training_words = [word for word in training_words if word[pos] == c]
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
    ''' The probability list doesn't always sum to 1, because floating point errors(?).
    this function is to bodge that.
    It find the difference and then alters the most likely value so the total is now 1 '''
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

def get_transition_matrices(length=5):
    wordlist = get_words(length=length)
    return [get_transition_matrix(wordlist, pos) for pos in range(0, length -1)]

def get_next_letter(wordlist, letter, position):
    letters = [a for a in string.ascii_lowercase]
    weights = get_transition_matrix(wordlist,position)[letters.index(letter)]
    next_letter = np.random.choice(letters,1,True,weights)[0]
    return next_letter

def invent_word(length=5):
    out = ""
    wordlist = get_words(length=length)
    letters = list(string.ascii_lowercase)
    seed = np.random.choice(letters,1,True,get_next_probability_list(wordlist,-1))[0]
    out += seed
    for i in range(0,length-1):
        weights = get_transition_matrix(wordlist,i)[letters.index(seed)]
        seed = np.random.choice(letters,1,True,weights)[0]
        out += seed

    return "".join(out)

def invent_word_with_constraint(length=5, includes="", excludes="", positions={}):
    out = ""
    wordlist = get_words_with_constraint(length=length,includes=includes,excludes=excludes,positions=positions)
    letters = list(string.ascii_lowercase)
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
