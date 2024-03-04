set.seed(123)

# Set the number of participants
num_participants <- 60

# Generate random alphanumeric IDs
random_ids <- sapply(1:num_participants, function(x) paste(sample(c(letters, LETTERS, 0:9), 10, replace = TRUE), collapse = ""))
#this line of code creates random participant IDs, it is relatively advanced, so don't worry about it means

df_demographics <- data.frame(
  ID = random_ids,
  gender = rep(c("Female", "Non-Binary", "Male"), 20),
  age = round(rnorm(n = 60, mean = 23, sd = 1), 0)
)


num_participants <- 42

# Generate random alphanumeric IDs
random_ids <- sapply(1:num_participants, function(x) paste(sample(c(letters, LETTERS, 0:9), 10, replace = TRUE), collapse = ""))
#this line of code creates random participant IDs, it is relatively advanced, so don't worry about it means

df_rt <- data.frame(
  ID = random_ids,
  condition = rep(c("no caffeine", "low caffeine", "high caffeine"), each = 14),
  mean_rt = round(rnorm(n = 42, mean = 200, sd = 50))
)

write.csv(df_demographics, "datasets/demographics.csv", row.names = FALSE)
write.csv(df_rt, "datasets/reaction_time.csv", row.names = FALSE)
