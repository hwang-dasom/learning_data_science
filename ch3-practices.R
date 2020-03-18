# Chapter 3 Practices

# 1.
library(gapminder)
library(dplyr)

gapminder %>% 
  filter(year == 2007) %>%
  select(country, gdpPercap)

gapminder %>%
  filter(year==2007) %>%
  group_by(continent) %>%
  summarize(mean = mean(lifeExp),
            median = median(lifeExp))

# 2.
setwd("git_repo/data-science")
test.data <- read.table("data/ipums.la.97")
glimpse(test.data)

data("rivers")
rivers
glimpse(rivers)
data("WorldPhones")
WorldPhones # matrix ==> DataFrome
dimnames(WorldPhones)
colnames(WorldPhones)[1]
rownames(WorldPhones)

wp_df <- data.frame()
wp_df
cont <- c(rep(colnames(WorldPhones), each=7))
year <- c(rep(rownames(WorldPhones), times=7))
data <- c(WorldPhones[,1],WorldPhones[,2],WorldPhones[,3], WorldPhones[,4], 
          WorldPhones[,5], WorldPhones[,6], WorldPhones[,7])

df <- data.frame(cont =c(rep(colnames(WorldPhones), each=7)), 
                 year=c(rep(rownames(WorldPhones), times=7)), 
                 data= c(WorldPhones[,1],WorldPhones[,2],WorldPhones[,3], WorldPhones[,4], 
                         WorldPhones[,5], WorldPhones[,6], WorldPhones[,7]))
df
df <- tbl_df(df)
df
#3. 데이터 범주별 요약 통계량
df %>% summarize(n_obs= n(),
                 n_continents = n_distinct(cont),
                 n_years = n_distinct(year))

df %>% group_by(cont) %>% summarize(
                           median = median(data),
                           min = min(data),
                           max = max(data))


#4. IMDB데이터 활용 from kaggle
credits <- tbl_df(read.csv("data/tmdb-movie-metadata/tmdb_5000_credits.csv"))
movies <- tbl_df(read.csv("data/tmdb-movie-metadata/tmdb_5000_movies.csv"))

#4-a. 변수
glimpse(credits) # movie_id, title, cast, crew
glimpse(movies)
names(credits)
names(movies)

#4-b. 연도별 리뷰받은 영화의 개수
substring(movies$release_date, 1,4)
movies %>%
  group_by(substring(release_date, 1,4)) %>%
  summarize(count=n())

movies %>%
  group_by(substring(release_date, 1,4)) %>%
  summarize(count = sum(vote_count))

# String -> Date
movies %>% 
  mutate(date=as.Date(release_date), year=year(date)) %>%
  group_by(year) %>%
  summarize(movies_n = n(), # # of reviewed movies by year
            total_review_cnt = sum(vote_count)) # total # of review counts by year

library(lubridate)
movies %>%
  mutate(date2=as_date(release_date), year2=year(date2)) %>%
  group_by(year2) %>%
  summarize(movies_n = n(),
            total_review_cnt = sum(vote_count))

#5. SQL 예제
# 5-a-i : SELECT EmployeeID, count(*) orders_cnt from Orders group by EmployeeID order by orders_cnt desc;
# 5-a-ii
# SELECT E.EmployeeID, E.LastName, E.FirstName, count(O.OrderID) count_orders
# FROM Employees E, Orders O
# WHERE E.EmployeeID == O.EmployeeID
# GROUP BY E.EmployeeID
# ORDER By count_orders DESC;
# 5-a-iii
# SELECT O.OrderID, O.OrderDate, SUM(P.price * O.Quantity) total_price , SUM(O.Quantity) n_itmes
# FROM (SELECT O.OrderID, O.OrderDate, Od.ProductID, Od.Quantity 
#       FROM Orders O INNER JOIN OrderDetails Od 
#       ON O.OrderID == Od.OrderID) O LEFT JOIN 
# Products P  ON P.productID = O.productID 
# GROUP BY O.OrderID;

