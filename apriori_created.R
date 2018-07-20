# Apriori

# Data Preprocessing

library(arules)
dataset = read.csv('Market_Basket_Optimisation.csv', header = FALSE)
# first line isn't titles
dataset = read.transactions('Market_Basket_Optimisation.csv', sep = ',', rm.duplicates = TRUE)
#duplicates items need to be removed
summary(dataset)
itemFrequencyPlot(dataset, topN = 10)

# Training Apriori on the dataset

rules = apriori(data = dataset, parameter = list(support = 0.004, confidence = 0.2))
#min support for product purchased 3 times per day = 3*7/ 7500 [total] = 0.0028
#0.8 is a very high confidence value

# Visualizing the Results
inspect(sort(rules, by='lift')[1:10])