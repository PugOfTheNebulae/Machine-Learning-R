# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('Mall_Customers.csv')
X = dataset[4:5]

# Using the dendrogram to find optimal # clusters
dendrogram = hclust(dist(X, method = 'euclidean'), method = 'ward.D')
plot(dendrogram,
     main = paste('Dendrogram'),
     xlab = 'Customers',
     ylab = 'Euclidean Dist')

#dendrogram shows that there should be 5 clusters based
#on longest cont. line approach

# Fitting hierarchical clustering to the datset
hc = hclust(dist(X, method = 'euclidean'), method = 'ward.D')
#find vector of values, cutting tree based on # of clusters
y_hc = cutree(hc, 5)

#visualizing the clusters
library(cluster)
clusplot(X,
         y_hc,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Clus of customers'),
         xlab = 'annual income',
         ylab = 'spending score')
         