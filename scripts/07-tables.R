df_clean

# Tables for Presentation -------------------------------------------------

pacman::p_load(
  rio,            # import/export
  here,           # file pathways
  flextable,      # make HTML tables
  officer,        # helper functions for tables
  tidyverse)      # data management, summary, and visualization


df_clean

df_clean$ID <- as.character(df_clean$ID)

table <- tibble(df_clean)

my_table <- flextable(table)

#automatically fixing column length

my_table <- my_table %>%
  autofit() #ensures that each table has only 1 row of text

#manually changing it

# my_table <- my_table %>%
#   width(j = 1, width = 1) %>% #this changes column 1
#   width(j = 4, width = 1.5) %>% #column 2
#   width(j = c(2, 4:10), width = 1)


#automatically fixing column length

my_table <- my_table %>%
  autofit() #ensures that each table has only 1 row of text


my_table_heading <- my_table %>%
  add_header_row(
    top = TRUE, #New header will go above existing column names
    values = c("Participant Demographics",
               "",
               "",
               "",
               "Remote Associations",
               "",
               "",
               "Mood",
               "Openness to Experience",
               "")) %>%
  set_header_labels(
    remote_pos = "Positive",
    remote_neg = "Negative",
    remote_neut = "Neutral",
    total_mood = "Total",
    total_openness = "Total",
    mean_openness = "M"
  ) %>%
  print

