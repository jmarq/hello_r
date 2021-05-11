library("gapminder")
library(tidyverse)
data("gapminder")

summary(gapminder)
mean(gapminder$gdpPercap)
median(gapminder$pop)
attach(gapminder)
median(pop)
hist(lifeExp)
hist(pop)
hist(log(pop))
hist(log(pop,exp(1)))
boxplot(lifeExp ~ continent, col=continent_colors)

gapminder %>%
  select(country, lifeExp) %>%
  filter(country == "South Africa" | country == "Ireland") %>%
  group_by(country) %>%
  summarise(Average_life = mean(lifeExp))


df1 <- gapminder %>%
  select(country, lifeExp) %>%
  filter(country == "South Africa" | country == "Ireland") 

t.test(data=df1, lifeExp ~ country)


gapminder %>%
  # filter(continent=="Americas") %>%
  ggplot(aes(x=log(gdpPercap), y=lifeExp, col=year, size=pop))+
  geom_point(alpha=0.5)+
  geom_smooth(method=lm) +
  facet_wrap(~continent)

  