# K-Means

# Importing the dataset
dataset = read.csv('Mall_Customers.csv')
X = dataset[4:5]

# Using the Elbow Method
set.seed(6)
wcss = vector() #creates an empty vector

for (i in 1:10) wcss[i] = sum(kmeans(X,i)$withinss)  #1:10 included, withinss computes sum of squares

# Plotting Elbow
plot(1:10, wcss, type = 'b', main = paste('Clusters of clients'), xlab = '# of clus', ylab = 'WCSS')

# Applying K-Means
set.seed(29)
kmeans = kmeans(X, 5, iter.max = 300, nstart = 10)

# Visualixing the clusters
library(cluster)
clusplot(X,
         kmeans$cluster, #vector w/ true cluster #'s
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Clusters of clients'),
         xlab = 'Annual Income',
         ylab = 'Spending Score (1-100)')

# centroids cannor be chosen random initially
# kmeans++ might help in choosing the proper initial clusters