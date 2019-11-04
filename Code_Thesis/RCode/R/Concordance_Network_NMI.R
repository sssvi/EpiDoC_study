# Given a list of affinity matrices, Wall, the number of clusters, return a matrix containing the NMIs
# between cluster assignments made with spectral clustering.

# First Row/Column: Comparing clustering with the fused network.
# Second Row/Column: Comparing clustering with the first affinity.
# ...
# Last Row/Column: Comparing clustering with the last affinity.
Concordance_Network_NMI = function(Wall, K) {
  # Calculate the fused network
  LW = length(Wall)
   # Get the cluster labels for each of the networks
  labels = lapply(Wall, function(x) spectralClustering(x, K))
  # Calculate the NMI between each pair clusters
  NMIs = matrix(NA, LW, LW)
  for (i in 1:LW) {
    for (j in 1:LW) {
      NMIs[i, j] = Cal_NMI(labels[[i]], labels[[j]]);
    }
  }
  
  return(NMIs)
}
