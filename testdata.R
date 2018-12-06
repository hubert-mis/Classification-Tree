library("dummies")

list(
  wiek = c('<20', '20-30', '>30'),
  plec = c('K', 'M'),
  mieszka = c('wies', 'miasto')
) %>% expand.grid() %>%
  bind_cols(
    reklama = as.character(factor(c(1, 1, 1, 1, 1, 1, 3, 2, 1, 3, 2, 2), labels = c("TV", "Prasa", "Net")))
  ) %>%
  dummy.data.frame(sep = ": ") %>% as.tibble() -> data

data[8:10] -> dependent
data[1:7] -> independent

write_csv(data, "testdata.csv")