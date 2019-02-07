txt <- system.file("texts","txt", package="tm")
(ovid <- Corpus(DirSource(txt, encoding = "UTF-8"),
                readerControl = list(language = "lat")))

reut21578 <- system.file("texts","crude",package="tm")
reuters <- Corpus(DirSource(reut21578),
                  readerControl=list(reader=readReut21578XML))
writeCorpus(ovid)
inspect(ovid[1:2])
identical(ovid[[2]],ovid[["ovid_2.txt"]])
reuters <- tm_map(reuters, as.PlainTextDocument)
reuters <- tm_map(reuters, stripWhitespace)
reuters <- tm_map(reuters, tolower)
reuters <- tm_map(reuters,removeWords, stopwords("english"))
tm_map(reuters, stemDocument)
DublinCore(reuters[[1]], "Creator") <- "Ano Nymous"
meta(reuters[[1]])
meta(reuters, tag = "test", type = "corpus") <- "test meta"
meta(reuters, type="corpus")
meta(reuters, "foo") <- letters[1:20]
meta(reuters)
meta(reuters[1])

dtm <- DocumentTermMatrix(reuters)
inspect(dtm[1:5,100:105])
findFreqTerms(dtm,5)
findAssocs(dtm, "opec", 0.8)
inspect(removeSparseTerms(dtm, 0.4))
inspect(DocumentTermMatrix(reuters,
                           list(dictionary=c("prices","crude","oil"))))


termFrequency <- rowSums(as.matrix(dtm))
termFrequency <- subset(termFrequency, termFrequency >= 5)
library(ggplot2)
qplot(names(termFrequency), termFrequency, geom="bar", xlab="Terms")+coord_flip()
barplot(termFrequency,las=2)


dtm2 <- removeSparseTerms(dtm, sparse=0.95)
m <- as.matrix(dtm2)
wordFreq <- sort(rowSums(m), decreasing=TRUE)
grayLevels <- gray( (wordFreq+10)/(max(wordFreq)+10))
library(wordcloud)
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=3, random.order=F,
          colors=grayLevels)