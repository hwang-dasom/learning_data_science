# Chapter 3. Data acquisition and data processing

# data source - https://archive.ics.uci.edu/ml/machine-learning-databases/housing
# data load 
boston <- read.table("housing.data")
dplyr::glimpse(boston)

names(boston)<-c('crim', 'zn','indus', 'chas', 'nox', 'rm', 'age', 'dis', 'rad', 'tax',
                 'ptratio', 'black', 'lstat', 'medv')

dplyr::glimpse(boston)

plot(boston)
summary(boston)

# very large data
# fread() 10x faster
library(data.table)
DT <- fread("very_big.csv") # return data.table object
DT <- fread("very_big.csv", data.table=FALSE) # return data.frame object


# EXCEL file : csv or library "readxl"
install.packages("readxl")
library(readxl)

# xsl, xslx
read.excel("my-old-spreadsheet.xls")
read.excel("my-new-spreadsheet.xlsx")

# read a specific spreadsheet
read_excel("my-spreadsheet.xls", sheet="data")
read_excel("my-spreadsheet.xls", sheet=2)

# Missing value 
read_excel("my-spreadsheet.xls", na="NA")

# RDBMS + SQL
#install.packages("sqldf")
library(sqldf)
sqldf("select * from iris")
sqldf("select count(*) from iris")
sqldf("select Species, count(*), avg(`Sepal.Length`) 
      from iris
      group by `Species`")

sqldf("select Species, `Sepal.Length`, `Sepal.Width`
      from iris
      where `Sepal.Length` < 4.5
      order by `Sepal.Width`")

# JOIN - "sqldf" does not have right join and outer join.
library(dplyr)
# data_frame() is deprecated. 
(df1 <- tibble(x=c(1,2), y=2:1))
(df2 <- tibble(x=c(1,3), a=10, b="a"))

sqldf("select * from df1 inner join df2
      on df1.x = df2.x")

sqldf("select * from df1 left join df2
      on df1.x = df2.x")

# Data import fro RDBMS
# Opt1. Store RDBMS SQL results into a text file, and read it from R.
# Opt2. Connect directly to RDBMS 
# libraries - Oracle : {ROracle} / MySQL: {RMySQL} / PostgreSQL: {RPostgreSQL} / ODBC : {RODBC}

# binary files - SPSS, SAS, ...
# Same with Opt1.
# Opt2. Use binary file library: library {foreign}

# install.packages("foreign")
library(foreign)
x <- read.dbf(system.file("files/sids.dbf", package="foreign")[1])
dplyr::glimpse(x)
summary(x)

# Data export
# useful functions: write.table(), write.csv()
# {readr} - read_csv(), write_csv()