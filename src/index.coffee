natural = require 'natural'
tokenizer = new natural.WordTokenizer()

# returns a list of the elements that appear in both lists
intersect_safe = (a, b) ->
  ai = 0
  bi = 0
  result = new Array()
  while ai < a.length and bi < b.length
    if a[ai] < b[bi]
      ai++
    else if a[ai] > b[bi]
      bi++
    # they're equal 
    else
      result.push a[ai]
      ai++
      bi++
  result

# split text body into words; return only uniques if unique=true
get_words = (text, unique=true) -> 
  words = tokenizer.tokenize text
  if unique
    uniques = {}
    for word in words
      uniques[word] = word
    return (k for k,v of uniques)
  else
    return words

# split text body into sentences
get_sentences = (text) -> (s.trim() for s in text.split /(\.)['”" \)\n]/g)

# split text body into paragraphs
get_paragraphs = (text) -> text.split /[\r\n]{2}/g

# return likeness (0-1) of two sentences
get_likeness = (s1, s2) ->
  unless s1 and s2
    return 0
  w1 = get_words(s1) 
  w2 = get_words(s2)
  if w1.length + w2.length is 0
    return 0
  else
    intersection = intersect_safe w1, w2
    return intersection.length / ((w1.length + w2.length)/2)

get_sentence_ranks = (paragraph) ->
  sentences = get_sentences paragraph
  # calculate the intersection of every two sentences
  matrix = ((0 for x in [0..sentences.length]) for x in [0..sentences.length])
  for i in [0...sentences.length]
    for j in [0...sentences.length]
      if i == j
        matrix[i][j] = 0
      else
        matrix[i][j] = get_likeness sentences[i], sentences[j]
  # Build the sentences dictionary
  # The score of a sentence is the sum of all its intersections
  sentences_dict = {}
  for i in [0...sentences.length]
    score = 0
    for j in [0...sentences.length]
      score += matrix[i][j]
    sentences_dict[sentences[i]] = score
  # return dict indicating intersection scores for every sentence
  return sentences_dict
  
get_best_sentence = (sentences_dict) ->
    best_sentence = ''
    max_value = -1
    for k, v of sentences_dict
      if v > max_value
        max_value = v
        best_sentence = k
    return best_sentence
  
get_summary = (content) ->
  summary = []
  paragraphs = get_paragraphs content
  for paragraph in paragraphs
    ranks = get_sentence_ranks paragraph
    best_sentence = get_best_sentence ranks
    summary.push best_sentence
  return (x for x in summary when x)

module.exports = get_summary