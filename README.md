# EpiDoC_study
Thesis work

This repository presents two different sets of code used to perform tests on the EpiDoC data, one regarding Python scripts and another with R scripts.

Python Code:\
Used to clean and discretize data (fullDataClean.py & discretization.py)\
Used to remove outliers found through DBSCAN on R (remove_outliers.py)\
Segment dataset for SNF (cutDataSegments.py)\
Prepare data input for BicPAMS (prep4bicpams.py)


R Code:\
Outlier detection and Dimensionality Reduction are performed through files DBSCAN.R & MCA.R, respectively\
Feature weights are calculated before applying the SNF method with weights.R

-- R folder:\
  Includes data taken from the ab-SNF paper and adapted for the EpiDoC study\
  File run_example.R performs the SNF method on the pre-processed data and calculates the resulting clustering indexes

Several resulting clusters from SNF can be analized side-by-side with the compare_clusters.R file\
Alluvial plots on the clusters created can be generated with alluvial_test.R
