library(sjmisc)
library(ggplot2)
library(ggalluvial)
library(dplyr)
library(alluvial)
library(plyr)


dataZ <- dataTotal
#dataZ$Freq <- seq.int(nrow(dataZ))
dataZ$Freq <- rep(1,nrow(dataZ))

head(dataZ)
n_cols = dim(dataZ)[2]
n_rows = dim(dataZ)[1]

#dataZ <- na.omit(dataZ)

n_cols = dim(dataZ)[2]
n_rows = dim(dataZ)[1]

is_alluvia_form(as.data.frame(dataZ), axes = 1:n_cols, silent = TRUE)

dataZ %>% group_by(Gender, BMI, Age) %>%
  summarise(n = n_rows) -> tit3d


ggplot(data = dataZ,
       aes(axis1 = Gender, axis2 = BMI, axis3 = Age,
           y = Freq)) +
  scale_x_discrete(limits = c("Gender", "BMI", "Age"), expand = c(.1, .05)) +
  xlab("Demographic") +
  geom_alluvium(aes(fill = Healthy)) +
  geom_stratum() + geom_text(stat = "stratum", label.strata = TRUE) +
  theme_minimal() +
  ggtitle("Characterization of pacients in the biggest cluster",
          "stratified by demographics and health state")

