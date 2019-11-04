## Run pvalue R file to pre proccess data to use
library(NbClust)
library(ggplot2)
library(factoextra)
library(fpc)
library(cluster)
library(igraph)
library(analogue)
library(clusterCrit)

# Calculate boosted distance matrices(here we calculate Euclidean Distance, 
#Dist1 = dist2_w(as.matrix(data1),as.matrix(data1),w1)
#Dist2 = dist2_w(as.matrix(data2),as.matrix(data2),w2)
#Dist6 = dist2_w(as.matrix(data6),as.matrix(data6),w6)

#K_thumb = round(sqrt(dim(data1)[1]))

# Calculate boosted distance matrices - Manhattan 
Dist1= analogue::distance(as.matrix(sweep(data1, MARGIN=2, w1, `*`)),method="manhattan")
Dist2= analogue::distance(as.matrix(sweep(data2, MARGIN=2, w2, `*`)),method="manhattan")
DistE= analogue::distance(as.matrix(sweep(data6, MARGIN=2, w6, `*`)),method="manhattan")

# Next, construct similarity graphs
W1 = affinityMatrix(Dist1)#, K=2)
W2 = affinityMatrix(Dist2)#, K=2)
WE = affinityMatrix(DistE)#, K=2)


#20, 20
W = SNF(list(W1,W2,WE), K = 20, t = 20)

# Draw graph 
GW = graph_from_adjacency_matrix(W, mode = 'max', weighted = TRUE, diag = FALSE)
plot(GW, vertex.size = 1, vertex.label = NA, layout=layout_nicely)

#Spectral clustering

#Test SNF data with kmeans clustering to determine best number of clusters
fviz_nbclust(W, kmeans, method = "wss", k.max = 10)+
  labs(subtitle = "Elbow method")
fviz_nbclust(W, kmeans, method = "silhouette", k.max = 10)+
  labs(subtitle = "Silhouette method")

C = 2
km.res <- eclust(W, "kmeans", k = C, graph = TRUE)
fviz_cluster(km.res, geom = "point", ellipse.type = "norm",
             palette = "jco", ggtheme = theme_minimal())


#Perform SpectralClustering with numbers of clusters suggested
group = spectralClustering(W, C)

displayClusters(W, group)

new_data <- cbind(group,W)
dataTotal %>% filter(group == 1) -> clust1

#W_stats <- cluster.stats(d = W, clustering = group)
#print(W_stats$cluster.size)
#print(W_stats$clus.avg.silwidths)
#print(W_stats$dunn)

W_statsEx <- intCriteria(W, group, c("Silhouette", "Dunn", "PBM", "Davies_Bouldin"))
print(W_statsEx$silhouette)
print(W_statsEx$dunn)
print(W_statsEx$pbm)
print(W_statsEx$davies_bouldin)

ConcordanceMatrix = Concordance_Network_NMI(list(W, W1, W2, WE), C)

#SNFNMI = Cal_NMI(group, truelabel)

