# chapter 3.6 데이터 가공
# Gapminder 
# install "gapminder" packages / data load
install.packages("gapminder")
library(gapminder)

# select data
# rows and columns
gapminder[gapminder$country=="Korea, Rep.", c('pop', 'gdpPercap')]
# rows
gapminder[gapminder$country=="Korea, Rep.",]
gapminder[gapminder$year==2007, ]
gapminder[gapminder$country=='Korea, Rep.' & gapminder$year==2007, ]
gapminder[1:10, ]
head(gapminder, 10)

# Sorting
gapminder[order(gapminder$year, gapminder$country),]

# select variables
gapminder[,c('pop', 'gdpPercap')]
gapminder[, 1:3]

# change a variable name
# gdpPercap -> gdp_per_cap
f2 = gapminder
names(f2)
names(f2)[6] = 'gdp_per_cap'

# add a new variable
f2 = gapminder
f2$total_gdp = f2$pop * f2$gdpPercap

# calculate summary statistics
median(gapminder$gdpPercap)
apply(gapminder[, 4:6], 2, mean)
summary(gapminder)

# IMPORTANT #
# dplyr
library(dplyr)

# useful utilities
# 1. tbl_df() : large data display
i2 <- tbl_df(iris)
class(i2)
i2

# 2. glimpse()
glimpse(i2)

# 3. pipe %>%
iris %>% head
iris %>% head(10)

# key functions
# 1. filter()
filter(gapminder, country=="Korea, Rep.")
filter(gapminder, year==2007)
filter(gapminder, country=='Korea, Rep.' & year==2007)

gapminder %>% filter(country=='Korea, Rep.')
gapminder %>% filter(year==2007)
gapminder %>% filter(country=='Korea, Rep.' & year==2007)

# 2. arrange() : sort asc
arrange(gapminder, year, country)
gapminder %>% arrange(year, country)

# 3. select() : column/variable
select(gapminder, pop, gdpPercap)
gapminder %>% select(pop, gdpPercap)

# 4. mutate(): new variable
gapminder %>% mutate(total_gdp = pop * gdpPercap, 
                     le_gdp_ratio = lifeExp / gdpPercap, 
                     lgrk = le_gdp_ratio * 100)

# 5. summarize() / summarise() : one-line summary 
# stat functions such as min, max, mean, sum, sd, median, IQR
# n() : # of rows / n_distinct(): # of distinctive values
# first(x), last(x), nth(x,n) : x's first value, last value, n-th value
gapminder %>% summarize(n_obs = n(),
                        n_countries = n_distinct(country),
                        n_years = n_distinct(year), 
                        med_gdpc = median(gdpPercap),
                        max_gdppc = max(gdpPercap))

# 6. sample_n() & sample_frac() : sampling
# default: sampling without replacemnet / replace=TRUE 
# weight= / 재현가능한 연구를 위한 set.seed()
sample_n(gapminder, 10)
sample_frac(gapminder, 0.01)

# 7. distinct()
distinct(select(gapminder, country))
distinct(select(gapminder, year))

gapminder %>% select(country) %>% distinct()
gapminder %>% select(year) %>% distinct()

# group_by()
gapminder %>% 
  filter(year==2007) %>%
  group_by(continent) %>%
  summarize(median(lifeExp))

# dplyr Chaining
gapminder %>%
  filter(year==2007) %>%
  group_by(continent) %>%
  summarize(lifeExp = median(lifeExp)) %>%
  arrange(-lifeExp)   # -lifeExp : sorting DESC by lifeExp

# dplyr JOIN
(df1 <- tibble(x=c(1,2), y=2:1))
(df2 <- tibble(x=c(1,3), a=10, b="a"))

df1 %>% inner_join(df2)
df1 %>% left_join(df2)
df1 %>% right_join(df2)
df2 %>% left_join(df1)
df1 %>% full_join(df2)