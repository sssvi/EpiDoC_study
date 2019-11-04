csPrediction <- function(W,Y0,method){
  ###This function implements the label propagation to predict the label(subtype) for new patients.	
  ### note method is an indicator of which semi-supervised method to use
  # method == 0 indicates to use the local and global consistency method
  # method >0 indicates to use label propagation method.
  
  alpha=0.9;
  P= W/rowSums(W)
  if(method==0){
    Y= (1-alpha)* solve( diag(dim(P)[1])- alpha*P)%*%Y0;
  } else {
    NLabel=which(rowSums(Y0)==0)[1]-1;
    Y=Y0;
    for (i in 1:1000){
      Y=P%*%Y;
      Y[1:NLabel,]=Y0[1:NLabel,];
    }
  }
  return(Y);
}
