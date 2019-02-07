set.seed(12345)
wordcloud(words=names(wordFreq.1st),
          freq = wordFreq.1st,
          min.freq=20,
          random.order = F)
