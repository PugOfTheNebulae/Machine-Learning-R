# Artificia Neural Networks

# processing
dataset = read.csv('Churn_Modelling.csv')
dataset = dataset[4:14]

# encoding categorical data as factors
#use the as.numeric function
dataset$Geography = as.numeric(factor(dataset$Geography,
                                      levels = c('France', 'Spain', 'Germany'),
                                      labels = c(1,2,3)))
dataset$Gender = as.numeric(factor(dataset$Gender,
                                   levels = c('Female','Male'),
                                   labels = c(1,2)))

#splitting into test and training set
library(caTools)
set.seed(123)
split = sample.split(dataset$Exited , SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# feature scaling
# necessary for ANN
training_set[-11] = scale(training_set[-11])
test_set[-11] = scale(test_set[-11])

# fitting the ANN to the training set
#install.packages('h2o') #connects to external server, reduce run time
library(h2o)
h2o.init(nthreads = -1) #optimize number of cores to use
# y  is exited, training_frame is training_set
#need to convert training_set to h2o frame
classifier = h2o.deeplearning(y = 'Exited', 
                              training_frame = as.h2o(training_set),
                              activation = 'Rectifier',
                              hidden = c(6,6),
                              epochs = 100, # num times dataset iterated
                              train_samples_per_iteration = -2 )#specifies # hidden layers and 2nd is # nodes)

# predicting the test set results
prob_pred = h2o.predict(classifier, newdata = as.h2o(test_set[-11]))
y_pred = (prob_pred > 0.5)
y_pred = as.vector(y_pred)

# making the confusion matrix
cm = table(test_set[,11], y_pred)

h2o.shutdown()
