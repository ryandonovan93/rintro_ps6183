
# Data Visualisation in R -------------------------------------------------

#prerequisites

#Remember to create a folder called week6 and set it as your working directory.

#This R script should be loaded into that folder

# Download the "df_personality.csv" data set into this folder as well

# Let's load in our packages and files ----------------------------------------------

#install.packages("tidyverse") if tidyverse does not load for you, then you will need to run this command (minus the #) in your console first
library(tidyverse)

#install.packages(c("jtools", "patchwork"))
library(jtools) #this package enables us to make APA themed plots
library(patchwork) #this package enables us to arrange plots we have created


#load in our file by running this line of code
df_personality <- read.csv("personality_RD.csv")
