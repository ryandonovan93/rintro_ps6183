#create flanker tasks

id <-  rep(df_background_clean$ID, each = 8)

f1 <- data.frame(
  participant..id = id,
  trial = rep(c("START", "Congruent", "Incongruent", "Congruent", "Incongruent",
                "Congruent", "Incongruent", "END"), 47),
  reaction.time = round(rnorm(n = 376, mean = 500, sd = 200), 3),
  stimulus = rep("positive", 376),
  condition = rep(c("ABC", "BCA", "CAB", "ACB"), each = 47)
) %>%
  mutate(reaction.time = ifelse(trial == "START", NA, reaction.time),
         reaction.time = ifelse(trial == "END", NA, reaction.time))

f2 <- data.frame(
  participant..id = id,
  trial = rep(c("START", "Congruent", "Incongruent", "Congruent", "Incongruent",
                "Congruent", "Incongruent", "END"), 47),
  reaction.time = round(rnorm(n = 376, mean = 400, sd = 300), 3),
  stimulus = rep("negative", 376),
  condition = rep(c("ABC", "BCA", "CAB", "ACB"), each = 47)
) %>%
  mutate(reaction.time = ifelse(trial == "START", NA, reaction.time),
         reaction.time = ifelse(trial == "END", NA, reaction.time))

f3 <- data.frame(
  participant..id = id,
  trial = rep(c("START", "Congruent", "Incongruent", "Congruent", "Incongruent",
                "Congruent", "Incongruent", "END"), 47),
  reaction.time = round(rnorm(n = 376, mean = 700, sd = 200), 3),
  stimulus = rep("neutral", 376),
  condition = rep(c("ABC", "BCA", "CAB", "ACB"), each = 47)
) %>%
  mutate(reaction.time = ifelse(trial == "START", NA, reaction.time),
         reaction.time = ifelse(trial == "END", NA, reaction.time))


write.csv(f1, "datasets/flanker_task1.csv", row.names = FALSE)
write.csv(f2, "datasets/flanker_task2.csv", row.names = FALSE)
write.csv(f3, "datasets/flanker_task3.csv", row.names = FALSE)


df

t.test(df$extra[df$group == 1],
       df$extra[df$group == 2],
       paired = TRUE)


t.test(sleep_df$extra[sleep_df$group == 1],
       sleep_df$extra[sleep_df$group == 2],
       paired = TRUE)


