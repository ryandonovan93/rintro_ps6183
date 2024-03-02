# Cleaning Remote Associations Dataset ------------------------------------

#This study investigated the effect of mood induction on convergent thinking
# 41 participants took part in the study when it was made live
# Participants answered questions relating to their mood, openness to experience, agem and gender
# Participants completed three remote associations tasks

# Set up our working directory

#Session -> Set Working Directory -> Choose Directory

#Create a folder called week4 and select it as your working directory


# Load in the "Tidyverse" Package ------------------------

#install.packages("tidyverse") #copy and paste this in the console first

library(tidyverse)


# Import our Data --------------------------------------------

df_raw <- read.csv("raw_remote_associations.csv") #make sure you have this in your working directory


View(df_raw)
head(df_raw)


# Select the Columns that we want -----------------------------------------


#the select function enables us to identify the columns we want (or to remove ones we do not want)

#the syntax for this function is: select(df, c(col1, col2, col3))



df_select <- select(df_raw, Participant.Private.ID,
                                 Experiment.Status,
                                 order,
                                 remote.assocotations.1,
                                 remote.assocotations.2,
                                 Remote.association.3,
                                 Response,
                                 response1,
                                 open1:gender)




#We can specify columns to remove with select() using the "-" operator

df_select <- select(df_select, -Response)


# Rename Our Columns ------------------------------------------------------



#the rename() function enables us to specify new column names.
#the syntax is: rename(df, new_name = old_name)



df_rename <- rename(df_select,
                    ID = Participant.Private.ID, #newcolname = oldcolname
                    status = Experiment.Status,
                    remote_pos = remote.assocotations.1,
                    remote_neg = remote.assocotations.2,
                    remote_neut = Remote.association.3,
                    total_mood = response1,
                    condition = order)






# Creating New Columns Using Mutate() -------------------------------------



#the mutate() function enables us to create new columns by performing calculations on existing columns in our data frame
#the syntax for creating new columns is: mutate(df, new_colum = calculation on existing_column)

#Let's create a total_openness variable



df_mutate <- mutate(df_rename,
                    total_openness = open1 + open2 + open3 + open4 + open5)





#what to do with the open items?




df_mutate <- mutate(df_rename,
                    total_openness = open1 + open2 + open3 + open4 + open5,
                    .keep = "unused") #this will remove the items open to open5




#what if we wanted to create mean_openness?`
`
#slighty a bit more complicated



df_mutate <- mutate(df_mutate,
                    #we use `select()` to pick the columns we want
                    mean_openness = rowMeans(select(df_mutate,
                                                    c(open1, open2, open3,
                                                      open4, open5))))






# Rewriting existing columns using mutate() -------------------------------

#the mutate() function enables us to rewrite existing columns by performing calculations on that column in our data frame
#the syntax for rewriting columns is: mutate(df, existing_column = calculation on existing_column(s))

#there is an error with remote_neg and remote_neut columns
#the maximum value should be 9
#what is going on here?

#how can we calculate the actual value of remote_neg and remote_neut?

df_mutate_ra <- mutate(df_mutate,
                       remote_neut = remote_neut - remote_neg,
                       remote_neg = remote_neg - remote_pos)

#remember to check with head() after everytime you create a data frame


#Let's check in our dataset

head(df_mutate_ra)



# Removing Duplicates using duplicated() and distinct() -------------------


#The duplicated() function checks each row of our dataset to see if any a row is a duplicate of another row

duplicated(df_mutate_ra_fixed) #if there is a TRUE, then there is a duplicate in our data




#we can use dataframe extraction to tell us which row is the duplicate
#df[rows_we_want, columns_we_want]


df_mutate_ra_fixed[duplicated(df_mutate_ra_fixed), ]




#now we can use the distinct() function to remove that duplicate from our data frame
#distinct only keeps in rows within our column that are unique


df_distinct <- distinct(df_mutate_ra_fixed)






#recheck with duplicated

duplicated(df_distinct) #should be all false







# Removing Rows using the filter() Function -------------------------------

#We can use the filter() function to selectively retain or discard rows in a dataset based on specified conditions.

#Its syntax is structured as follows: filter(dataframe, condition), where the condition specifies which rows to retain.

#Let's keep only the participants that were collected after the study was made live



df_filter <- filter(df_distinct, status == "live")




#we can also tell filter() which rows NOT to keep




df_filter_neg <- filter(df_distinct, status != "preview") #!= means NOT EQUAL



## Now - do we need the status column? Probably not.



df_filter <- select(df_filter, -status) #removes status column



# Removing Rows Using Multiple Conditions with filter() -------------------

#Let's say we want to remove any participant that did not score more than 0 on ANY of the remote association tasks
#So we want to remove participants who score 0 on remote_pos, remote_neg, and remote_neut


#we can use the arrange() to see if there are any people with scores like this
#the arrange() sorts our data in ascending order.
#the syntax for arrange is: arrange(df, col1, col2, col3.....col n)
#the order in which you input columns is the order in which priority will be given when arranging the data



df_filter <- arrange(df_filter, remote_pos, remote_neg, remote_neut)

#remember to check with head() after everytime you create a data frame




#how can we remove these 3 participants? Well we can use multiple conditions and
#combine it with the OR operator - "|"


df_filter_multi <- filter(df_filter, remote_pos > 0 | remote_neg > 0 | remote_neg > 0)

nrow(df_filter_multi)



#What if we wanted to be stricter?
#What if we wanted to remove any participant that scored 0 in ANY of these tasks?
#We need to use the AND operator "&"



df_filter_multi_strict <- filter(df_filter, remote_pos > 0 & remote_neg > 0 & remote_neg > 0)


nrow(df_filter_multi_strict) #see how many participants are left




#& is probably too strict, let's go with df_filter_multi instead

df_filter_multi

# Identifying the Factors in our Data Frame -------------------------------

#Certain inferential tests will need factors as inputs
#even though we have two categorical variables that are probably factors, gender and condition, neither are coded as that at the moment

glimpse(df_filter_multi)


#we can use mutate() here along with the function as.factor()
#remember mutate(df, existing_column = calculation on existing column)


df_factor <- mutate(df_filter_multi,
                    gender = as.factor(gender),
                    condition = as.factor(condition))



glimpse(df_factor)



# Summarising our Data by Groups using group_by() and summarise() ---------

#If we look at our data frame now, I would say it is clean
#We can change its name to df_clean


df_clean <- df_factor


#now we can actually start summarising our data using summarise() and group_by()

#The summarise() function enables you to calculate specific descriptive statistics for columns in your data frame.
#summarise(df, output_statistic = statistic function(column))

#Let’s use summarise() to display the number of participants and the mean and SD scores for our remote_association variables



sum_df <- summarise(df_clean,

                    n = n(), #the n() function counts the number of rows in your sample

                    mean_remote_pos = mean(remote_pos),
                    sd_remote_pos = sd(remote_pos),

                    mean_remote_neg = mean(remote_neg),
                    sd_remote_neg = sd(remote_neg),

                    mean_remote_neut = mean(remote_neut),
                    sd_remote_neut = sd(remote_neut))

sum_df







#Where summarise() really shines is when you use it in conjunction with group_by().

#group_by(gender)

group_gender <- group_by(df_clean, gender)


sum_gen_df <- summarise(group_gender,
                        n = n(),

                        mean_remote_pos = mean(remote_pos),
                        sd_remote_pos = sd(remote_pos),

                        mean_remote_neg = mean(remote_neg),
                        sd_remote_neg = sd(remote_neg),

                        mean_remote_neut = mean(remote_neut),
                        sd_remote_neut = sd(remote_neut))

#group_by(condition)

group_condition <- group_by(df_clean, condition)

sum_condition_df <- summarise(group_condition,
                              n = n(),

                              mean_remote_pos = mean(remote_pos),
                              sd_remote_pos = sd(remote_pos),

                              mean_remote_neg = mean(remote_neg),
                              sd_remote_neg = sd(remote_neg),

                              mean_remote_neut = mean(remote_neut),
                              sd_remote_neut = sd(remote_neut))


#group_by(condition, gender)


group_multi <- group_by(df_clean, condition, gender)

multi_df <- summarise(group_multi,
                      n = n(),

                      mean_remote_pos = mean(remote_pos),
                      sd_remote_pos = sd(remote_pos),

                      mean_remote_neg = mean(remote_neg),
                      sd_remote_neg = sd(remote_neg),

                      mean_remote_neut = mean(remote_neut),
                      sd_remote_neut = sd(remote_neut))



# Chaining it all together with the Pipe operator -------------------------

#The way we have cleaned our data is perfectly legitimate and probably the most beginner friendly.
#But it is cumbersome as we have to create several intermediate data frames and makes the code significantly longer

#Tidyverse has a operator called the pipe (%>%), which enables us to chain together multiple functions into a single, cohesive block of code.
#whenever you see %>%, just think of AND THEN
#shortcut for pipe (press at same time) for Windows: Control Shift M
#for Mac: Command Shift M

#Let’s say I wanted to create a data frame (df_demo) with only demographic information and with variable gender changed to sex.



df_demo_pipe <- df_clean %>% #create a variable called df_demo_pipe. To create it, take the df_clean data frame AND THEN (%>%)
  select(ID, age, gender) %>%  #select its columns ID, age, gender AND THEN
  rename(sex = gender) #rename gender to sex




# Using a Pipe Operator on the Remote Associations Data Frame -------------

df_clean_pipe <- df_raw %>%  #we take our raw dataframe AND THEN ( %>% )
  select(Participant.Private.ID, Experiment.Status, age, gender, order, response1, remote.assocotations.1:Remote.association.3, open1:open5) %>%  #we select the columns we want AND THEN

  rename(ID = Participant.Private.ID, #newcolname = oldcolname
         status = Experiment.Status,
         remote_pos = remote.assocotations.1,
         remote_neg = remote.assocotations.2,
         remote_neut = Remote.association.3,
         total_mood = response1,
         condition = order) %>% #We RENAME our columns AND THEN

  mutate(total_openness = open1 + open2 + open3 + open4 + open5,
         .keep = "unused") %>% #we create the total_openess column and fix the remote columns AND THEN

  mutate(remote_neut = remote_neut - remote_neg,
         remote_neg = remote_neg - remote_pos,) %>%

  distinct() %>%  #remove duplicates

  filter(status == "live" & (remote_pos > 0 | remote_neg > 0 | remote_neg > 0)) %>%


  mutate(gender = as.factor(gender),
         condition = as.factor(condition))



#now we can use the pipe to generate descriptive statistics

df_clean_pipe %>%
  group_by(condition, gender) %>%
  summarise(
    n = n(),

    mean_remote_pos = mean(remote_pos),
    sd_remote_pos = sd(remote_pos),

    mean_remote_neg = mean(remote_neg),
    sd_remote_neg = sd(remote_neg),

    mean_remote_neut = mean(remote_neut),
    sd_remote_neut = sd(remote_neut))
