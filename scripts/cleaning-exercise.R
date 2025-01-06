# Cleaning Flanker Test Dataset ------------------------------------

#This study investigated the effect of alcohol consumption to inhibit incongruent responses (e.g., flanker effect)
# 50 participants took part in the study when it was made live
# Participants answered questions relating to their age, gender, neuroticism.
# Participants were split into two conditions - control (no alcohol) and experiment (high alcohol)

# Load in the "Tidyverse" Package ------------------------

library(tidyverse)

#Reset your Environment

#In the environment tab, click the brush icon to clear you environment (this will remove any variables you have created)
#this will prevent you accidentally using a variable from when we cleaned the remote associations task

# Import our Data --------------------------------------------

df_raw <- read.csv("flanker.csv") #make sure you have this in your working directory

#run these to get a view of your dataframe
View(df_raw)
head(df_raw)

colnames(df_raw)


# Exercise Instructions ------------------------------------------------------------

#1. Create a variable called df_select. Use the select() to choose the columns relating to participant ID, experiment status (live or preview),
#age, study condition (control versus experiment), the flanker tasks
# gender, #flanker tasks (both congruent and incongruent), and the neuroticism items






#2. Create a variable called df_rename. Rename the messy columns to the following names:
# - ID
# - status [i.e., referring to whether they were in preview or live]
# - age
# - gender
# - condition [i.e., referring to whether they were in experimental or control]
# - flanker_congruent
# - neuro1
# - neuro2
# - neuro3
# - neuro4
# - neuro5



#3. Create a variable called df_mutate. Using the mutate() function create a variable called neuro_total that is the
# sum of each neuroticism item. Remove the neuro items using .keep = "unused"





#4. Create a variable called df_mutate_flanker. Using the mutate() function create a variable called flanker_effect
#The formula for the flanker effect is: flanker_effect = flanker_congruent - flanker_incongruent






#5. Create a variable called df_filter.
#filter out the participants who took the preview experiment and are younger than 18
#there are two ways to do this! (check your answer with nrow(you should have 50 participants afterwards))






#6. Create a variable called df_distinct. Remove any duplicate participants (there are 4)






#7. Create a variable called df_factor.
#Convert the columns relating to experimental condition and gender using mutate() and as.factor()






#use glimpse() to check whether it worked




#8. Create a variable called df_clean with the following code: df_clean <- df_factor






#9. Try using the %>% operator chain your code together, save it to df_clean_pipe

