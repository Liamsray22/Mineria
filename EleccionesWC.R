install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")

library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

text <- readLines(file.choose())
docs <-Corpus(VectorSource(text))

#inspect(docs)

toSpace <- content_transformer(function(x, pattern ) gsub (pattern , "", x))

docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
#docs <- tm_map(docs, toSpace, ".")




docs <- tm_map(docs,tolower)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("spanish"))
docs <- tm_map(docs, stripWhitespace)

#docs <- tm_map(docs, removeWords, c(""))

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d<- data.frame(word = names(v), freq=v)

head(d,30)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq,min.freq = 1,max.words = 50, 
          random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8,"Dark2") )