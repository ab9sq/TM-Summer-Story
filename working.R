set.seed(12345)

require(RColorBrewer)

pal <- brewer.pal(9,"BuGn")
pal <- pal[-(1:4)]

pal <- brewer.pal(6,"Dark2")
pal <- pal[-(1)]
           
           
jpeg(filename = "summer.jpeg",
     width = 5,
     height = 5,
     units = "in",
     res = 600,
     quality = 90)
wordcloud(words=names(wordFreq.1st),
          freq = wordFreq.1st,
          min.freq=50,
          random.order = F,
          random.color = TRUE,
          colors = pal)
dev.off()
