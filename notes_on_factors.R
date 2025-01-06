## Notes on Functions

#install.packages(pacman)

library(pacman)

pacman::p_load(
  rio,           # import/export
  here,          # filepaths
  lubridate,     # working with dates
  forcats,       # factors
  aweek,         # create epiweeks with automatic factor levels
  janitor,       # tables
  tidyverse      # data mgmt and viz
)

linelist <- import("datasets/linelist_cleaned.rds")

linelist <- linelist %>%
  mutate(delay_cat = case_when(
  #if criteria          new value if true
  days_onset_hosp < 2 ~"<2 days",
  days_onset_hosp >=2 & days_onset_hosp < 5 ~ "2-5 days",
  days_onset_hosp >= 5 ~ ">5 days",
  is.na(days_onset_hosp) ~ NA_character_,
  TRUE ~ "Check me"))

table(linelist$delay_cat, useNA = "always")


linelist <- linelist |>
  mutate(delay_cat = fct_relevel(delay_cat))

levels(linelist$delay_cat)

linelist <- linelist |>
  mutate(delay_cat = fct_relevel
         (delay_cat, "<2 days", "2-5 days", ">5 days"))

barplot(table(linelist$delay_cat))


