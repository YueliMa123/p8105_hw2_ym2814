library(tidyverse)
library(readxl)
library(janitor)

q1a_df = read_excel("data/Trash-Wheel-Collection-Totals-7-2020-2.xlsx", sheet = "Mr. Trash Wheel", range = "A2:N535")
drop_na(q1a_df_cleannames)
q1a_df_cleannames
view(q1a_df_cleannames)
q1a_df_cleannames %>% drop_na()
view(q1a_df_cleannames)
withoutna_df = na.omit(q1a_df_cleannames)
view(withoutna_df)
final_df = mutate(withoutna_df,sports_balls = round(sports_balls,1))
view(final_df)

my2019_df = read_excel("data/Trash-Wheel-Collection-Totals-7-2020-2.xlsx", sheet = "2019 Precipitation", range = "A2:B14")
my2018_df = read_excel("data/Trash-Wheel-Collection-Totals-7-2020-2.xlsx", sheet = "2018 Precipitation", range = "A2:B14")

combined_df = combine(mutate(my2019_df, year = 2019),mutate(my2018_df, year = 2018))
view(combined_df)
mutate(combined_df, Month = month.name[Month])

q2_df = read_csv("data/fivethirtyeight_datasets/pols-month.csv")
q2_sep = separate(q2_df, col = mon, into=c('Year','Month', 'Day'), sep = '-')
q2_numeric = mutate(q2_sep, Month = as.numeric(Month), Year = as.numeric(Year), Day = as.numeric(Day))
mutate(q2_numeric, Month= month.name[Month])
q2_numeric = mutate(q2_numeric, President = prez_gop)
view(q2_numeric)
q2_numeric = mutate(q2_numeric, President = ifelse(President==1,"repub","demo"))
view(q2_numeric)
q2_numeric = select(q2_numeric, -Day)
q2_numeric = select(q2_numeric, -prez_gop)
q2_numeric = select(q2_numeric, -prez_dem)
view(q2_numeric)


q2b_df = read_csv("data/fivethirtyeight_datasets/snp.csv")
q2b_sep = separate(q2b_df, col = date, into=c('Month','Day', 'Year'), sep = '/')
q2b_numeric = mutate(q2b_sep, Month = as.numeric(Month), Year = as.numeric(Year), Day = as.numeric(Day))
mutate(q2b_numeric, Month= month.name[Month])
q2b_numeric = select(q2b_numeric, -Day)
q2b_numeric = relocate(q2b_numeric,Year, .before = Month)
q2b_numeric = mutate(q2b_numeric, Year = ifelse(Year<20, Year+2000, Year+1900))
view(q2b_numeric)

q2c_df = read_csv("data/fivethirtyeight_datasets/unemployment.csv")
tidy_verse = 
  q2c_df %>%
  pivot_longer(
    Jan:Dec,
    names_to = "Month",
    values_to = "Unemployment"
  )
view(tidy_verse)
