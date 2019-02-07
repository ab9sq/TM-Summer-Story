# init
require(tm)
require(wordcloud)
require(ggplot2)

#input
slc <- Corpus(DirSource("~/r/workspace/TM/Data/Q12/"))

#clean up
slc.raw <- slc
dictionary <- c("Abbott",
                "Diagnostics",
                "ADD",
                "Form",
                "Page",
                "Document",
                "document",
                "Number",
                "Edition",
                "Effective",
                "Date",
                "Non-Product",
                "Computerized",
                "Production")
slc <- tm_map(slc, removeWords, dictionary)
slc <- tm_map(slc, tolower)
slc <- tm_map(slc, removePunctuation, preserve_intra_word_dashes = TRUE)
slc <- tm_map(slc, removeNumbers)
slc <- tm_map(slc, stripWhitespace)
slc <- tm_map(slc, removeWords, stopwords('english'))
slc.2 <- slc
#stem and rebuild
slc <- tm_map(slc, stemDocument)
slc <- tm_map(slc, stemCompletion, dictionary = slc.2)


slcTdm <- TermDocumentMatrix(slc, control=list(wordLengths=c(1, Inf)))
slcTdm
findFreqTerms(slcTdm, lowfreq=10)
termFrequency.slc <- rowSums(as.matrix(slcTdm))
termFrequency.slc <- subset(termFrequency.slc, termFrequency.slc>=10)


#qplot(names(termFrequency.slc), termFrequency.slc, geom="bar", xlab="Terms")+coord_flip()
#barplot(termFrequency.slc,las=2)

slcTdm.2 <- removeSparseTerms(slcTdm, sparse=0.90)

m <- as.matrix(slcTdm.2)
wordFreq <- sort(rowSums(m), decreasing=TRUE)

wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=20, random.order=F)

wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=25, random.order=F)

