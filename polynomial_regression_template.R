# Data Preprocessing 

# Importing the dataset

#remove unnecessary columns (column 1)
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

#*************************************************
# Splitting the dataset into the Training set and Test set

# install.packages('caTools')
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$DependentVariable, SplitRatio = 0.8)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

#************************************************
#Predicting Results with Polynomial Regression

y_pred = predict(regressor, data.frame(Level = 6.5))

#************************************************
# Feature Scaling

# training_set = scale(training_set)
# test_set = scale(test_set)

#***********************************************
#Create Regressor
regressor = lm(formula = dep var~.,
               data = Data)

#***********************************************
#Visualizing the dataset
library(ggplot2)
#higher res, smooth curve
x_grid  =seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x =dataset$Level , y = dataset$dep var),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue')

