library(tidyverse)



fundraising <- read_csv("C:/dev/congress/raw/2022 election cycle fundraising.csv")

states <- tibble(
  state = state.name, 
  state_abb = factor(state.abb), 
  state_area = state.area, 
  state_lon = state.center$x, 
  state_lat = state.center$y, 
  state_div = factor(state.division), 
  state_reg = factor(state.region))

fundraising_t <- fundraising %>% 
  tibble() %>%
  mutate(i = as.integer(index),
         member = str_to_upper(Member),
         party = factor(str_to_upper(Party), labels = c('D', "I", "R")),
         state = State,
         chamber = factor(str_to_upper(Chamber)),
         raised =  as.numeric(gsub("[\\$,]", "", Raised)),
         spent =  as.numeric(gsub("[\\$,]", "", Spent)),
         cash =  as.numeric(gsub("[\\$,]", "", `Cash on Hand`)),
         debt =  as.numeric(gsub("[\\$,]", "", Debts))) %>%
  select(i:debt) %>%
  left_join(states)

glimpse(fundraising_t)
