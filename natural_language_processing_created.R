# Natural Language Processing

# Import the data
dataset_original = read.delim('Restaurant_Reviews.tsv', quote = '', stringsAsFactors = FALSE)

# Cleaning the text
library(tm)
library(SnowballC)
corpus = VCorpus(VectorSource(dataset_original$Review))
corpus = tm_map(corpus, content_transformer(tolower))
# as.character(corpus[[1]])
corpus = tm_map(corpus, removeNumbers)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords()) #stop words, unneccesary
corpus = tm_map(corpus,stemDocument)
corpus = tm_map(corpus,stripWhitespace)

# Creating the bag of words model
dtm = DocumentTermMatrix(corpus)  #document term matrix
dtm = removeSparseTerms(dtm, 0.999) #keeps 99.9% of the most frequent words
dataset = as.data.frame(as.matrix(dtm))
dataset$Liked = dataset_original$Liked
  
###############################################################

# Random Forest
dataset$Liked = factor(dataset$Liked, levels = c(0, 1))

library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting classifier to the Training set
library(randomForest)
classifier = randomForest(x = training_set[-692], 
                          y = training_set$Purchased, 
                          ntree = 10)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-692])

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)

##############################################################

# Naive Bayes
# dataset$Liked = factor(dataset$Liked, levels = c(0, 1))
# 
# # Splitting the dataset into the Training set and Test set
# # install.packages('caTools')
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Liked, SplitRatio = 0.8)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)
# 
# # Fitting classifier to the Training set
# library(e1071)
# classifier = naiveBayes(x = training_set[-692],
#                         y = training_set$Liked)
# # Predicting the Test set results
# y_pred = predict(classifier, newdata = test_set[-692])
# 
# # Making the Confusion Matrix
# cm = table(test_set[, 692], y_pred)
