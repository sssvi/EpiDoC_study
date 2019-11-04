library(FactoMineR)
library(factoextra)

dims = dim(dataNoOutliers)[2]
dims = round(0.7*dims)

bigdataMCA <- dataNoOutliers

for (i in 1:ncol(bigdataMCA)) bigdataMCA[,i]=as.factor(bigdataMCA[,i])

resdataMCA <- MCA(bigdataMCA, ncp=dims)

fviz_screeplot(resdataMCA, addlabels =TRUE, ylim = c(0, 10))
fviz_contrib(resdataMCA, choice ="var", axes = 1, top = 50)
fviz_contrib(resdataMCA, choice ="var", axes = 2, top = 50)

res.var <- resdataMCA$var
var_coord <- res.var$coord          # Coordinates
var_contrib <- res.var$contrib        # Contributions to the PCs
res.var$cos2           # Quality of representation

res.ind <- resdataMCA$ind
ind_coord <- res.ind$coord          # Coordinates
ind_contrib <- res.ind$contrib        # Contributions to the PCs
res.ind$cos2           # Quality of representation

eig.values <- get_eigenvalue(resdataMCA)
head(round(eig.values, 2))

eig_V <- eig.values[,1]
max(eig_V)
keep_dim <- round(0.7*length(eig_V))
keep_dim

