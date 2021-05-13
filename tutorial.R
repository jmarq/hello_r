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

worldYears <- gapminder %>% group_by(year) %>% summarise(life_mean=mean(lifeExp))
worldYears %>% ggplot(aes(x=year, y=life_mean)) + geom_line()

hwy_means <- mpg %>% group_by(manufacturer) %>% summarise(hwy_mean=mean(hwy), disp_mean=mean(displ))
plot(hwy_means$hwy_mean ~ hwy_means$disp_mean)
abline(lm(hwy_means$hwy_mean ~ hwy_means$disp_mean), col="red")

  