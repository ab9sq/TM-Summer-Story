library(tm)


story <- Corpus(DirSource("~/r/workspace/TM/Data/story/"))

story <- tm_map(story, tolower)
story <- tm_map(story, removePunctuation)
story <- tm_map(story, removeNumbers)
story <- tm_map(story, removeWords, stopwords('english'))
story.copy <- story
story <- tm_map(story, stemDocument)
story <- tm_map(story, stemCompletion, dictionary = story.copy)

inspect(story[1])


miningCases <- tm_map(story.copy, grep, pattern="ass")
sum(unlist(miningCases))



myTdm <- TermDocumentMatrix(story, control=list(wordLengths=c(1, Inf)))
myTdm

idx <- which(dimnames(myTdm)$Terms == "rope")

inspect(myTdm[idx,])

myTdm <- TermDocumentMatrix(story, control=list(minWordLength = 1))




findFreqTerms(myTdm, lowfreq=100)
termFrequency <- rowSums(as.matrix(myTdm))
termFrequency <- subset(termFrequency, termFrequency>=100)
library(ggplot2)
qplot(names(termFrequency), termFrequency, geom="bar", xlab="Terms")+coord_flip()
barplot(termFrequency,las=2)
findAssocs(myTdm, "summer", 0.8)


library(wordcloud)
myTdm2 <- removeSparseTerms(myTdm, sparse=0.95)


m <- as.matrix(myTdm2)
wordFreq <- sort(rowSums(m), decreasing=TRUE)
grayLevels <- gray( (wordFreq+10)/(max(wordFreq)+10))

wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=3, random.order=F,
          colors=grayLevels)

#myTdm2 <- removeSparseTerms(myTdm, sparse=0.95)

m2 <- as.matrix(myTdm2)
distmatrix <- dist(scale(m2))
fit <- hclust(distmatrix, method="ward")
plot(fit)
rect.hclust(fit, k=10)
(groups <- cutree(fit, k=10))

findFreqTerms(myTdm2, lowfreq=5)

m3 <- (m2)
set.seed(122)
k <- 8
kmeansResult <- kmeans(m3, k)
round(kmeansResult$centers, digits=3)

library(fpc)
pamResult <- pamk(m3, metric="manhattan")
(k <- pamResult$nc)
pamResult <- pamResult$pamobject
for(i in 1:k){
   cat(paste("cluster", i, ":  "))
   cat(colnames(pamResult$medoids)[i], "\n")
   #
   #
}



pamResult2 <- pamk(m3,krange=2:8, metric="manhattan")


pamResult2$nc
pamResult2 <- pamResult2$pamobject
plot(pamResult2, color=F, labels=4, lines=0, cex=0.8, col.clus=1,
     co.p=pamResult$clustering)





story.2 <- tm_map(story, removeWords, c("summer","todd","master"))


myTdm.2 <- TermDocumentMatrix(story.2, control=list(wordLengths=c(1, Inf)))
myTdm.2

idx <- which(dimnames(myTdm.2)$Terms == "ass")

inspect(myTdm.2[idx,])

myTdm.2 <- TermDocumentMatrix(story.2, control=list(minWordLength = 1))




findFreqTerms(myTdm.2, lowfreq=100)
termFrequency.work <- rowSums(as.matrix(myTdm.2))
termFrequency.2 <- subset(termFrequency.work, termFrequency>=100)

qplot(names(termFrequency.2), termFrequency.2, geom="bar", xlab="Terms")+coord_flip()
barplot(termFrequency.2,las=2)
findAssocs(myTdm.2, "ass", 0.8)




m.2 <- as.matrix(myTdm.2)
wordFreq.2 <- sort(rowSums(m.2), decreasing=TRUE)
grayLevels <- gray( (wordFreq.2+10)/(max(wordFreq.2)+10))

wordcloud(words=names(wordFreq.2), freq=wordFreq.2, min.freq=2, random.order=F,
          colors=grayLevels)























pdf(file="~/R/workspace/TM/story.pdf", width=8.25, height=10.75)
