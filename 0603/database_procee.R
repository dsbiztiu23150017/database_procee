library(tidyverse)

d <- data.frame(
  name = c("太郎", "花子", "三郎", "良子", "次郎", "桜子", "四郎", "松子", "愛子"),
  school = c("南", "南", "南", "南", "南", "東", "東", "東", "東"),
  teacher = c("竹田", "竹田", "竹田", "竹田",  "佐藤", "佐藤", "佐藤", "鈴木", "鈴木"),
  gender = c("男", "女", "男", "女", "男", "女", "男", "女", "女"),
  math = c(4, 3, 2, 4, 3, 4, 5, 4, 5),
  reading = c(1, 5, 2, 4, 5, 4, 1, 5, 4) )

d


#問題１

con <- dbConnect(duckdb())
duckdb_register(con, "d", d)
duckdb_data <- tbl(con, "d")
print(duckdb_data)

tbl(con,'d') |>
  select(name,math) |>
  collect() -> res

print(res)


#問題２

tbl(con,'d') |>
  select(-gender) |>
  collect() -> res

print(res)


#問題３

tbl(con,'d') |>
  collect() |>
  slice(3:6) -> res

print(res)


#問題４

tbl(con,'d') |>
  arrange(name) |>
  collect() -> res

print(res)


#問題5

tbl(con,'d') |>
  arrange(desc(math)) |>
  collect() -> res

print(res)


#問題6

tbl(con,'d') |>
  arrange(desc(math),desc(reading)) |>
  collect() -> res

print(res)


#問題7

tbl(con,'d') |>
  select(math,reading) |>
  collect() -> res

print(res)


#問題8

tbl(con,'d') |>
  summarize(math_mean=mean(math)) |>
  collect() -> res

print(res)


#問題9

tbl(con,'d') |>
  group_by(teacher) |>
  summarize(math_mean=mean(math)) |>
  collect() -> res

print(res)


#問題10

tbl(con,'d') |>
  filter(gender=="女") |>
  select(name:math) |>
  collect() -> res

print(res)


#問題11

tbl(con,'d') |>
  filter(gender=='男',school=='南') |>
  collect() -> res

print(res)


#問題12

tbl(con,'d') |>
  group_by(teacher) |>
  filter(n()>=3) |>
  collect() -> res

print(res)


#問題12α

tbl(con,'d') |>
  group_by(teacher) |>
  filter(n()>=3) |>
  summarize(students=n()) |>
  collect() -> res

print(res)


#問題13

tbl(con,'d') |>
  mutate(total=math+reading) |>
  collect() -> res

print(res)


#問題14

tbl(con,'d') |>
  mutate(math100=math*100/5) |>
  collect() -> res

print(res)



duckdb_unregister(con, "d") 
dbDisconnect(con, shutdown = TRUE)
