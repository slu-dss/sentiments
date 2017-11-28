library(dplyr)
library(tidytext)

frostRoads <- read.delim("frostRoads.txt", header = FALSE)

frostRoads %>%
  rename(text = V1) %>%
  mutate(text = as.character(text)) %>%
  mutate(linenumber = row_number()) %>%
  ungroup() %>%
  unnest_tokens(word, text) -> tidyRoads

tidyRoads %>%
  inner_join(get_sentiments("bing")) %>%
  count(index = linenumber %/% 2, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) -> sentimentRoads

ggplot(sentimentRoads, aes(x = index, y = sentiment)) +
  geom_col(fill = "#F8766D") +
  labs(
    title = "The Road Not Taken by Robert Frost",
    subtitle = "Sentiment Analysis")

frostXmas <- read.delim("frostXmas.txt", header = FALSE)

frostXmas %>%
  rename(text = V1) %>%
  mutate(text = as.character(text)) %>%
  mutate(linenumber = row_number()) %>%
  ungroup() %>%
  unnest_tokens(word, text) -> tidyXmas

tidyXmas %>%
  inner_join(get_sentiments("bing")) %>%
  count(index = linenumber %/% 2, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) -> sentimentXmas

ggplot(sentimentXmas, aes(x = index, y = sentiment)) +
  geom_col(fill = "#F8766D") +
  labs(
    title = "Christmas Trees by Robert Frost",
    subtitle = "Sentiment Analysis")
