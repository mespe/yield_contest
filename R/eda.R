# Exploratory Data Analysis
# M. Espe
# 2023-08-23

d = readRDS("data/yield_cleaned.rds")

library(ggplot2)

ggplot(d, aes(y = Yield, x = topdress)) +
  geom_boxplot() +
  facet_wrap(~Year)

ggplot(d, aes(y = Yield, x = factor(Year))) +
  geom_boxplot()

ggplot(d, aes(y = Yield, x = Variety)) +
  geom_boxplot()

ggplot(d, aes(y = Yield, x = Grower)) +
  geom_boxplot()

ggplot(d, aes(y = Yield, x = Grower)) +
  geom_boxplot() +
  facet_wrap(~Region)

ggplot(d, aes(y = Yield, x = Variety)) +
  geom_boxplot() +
  facet_wrap(~Region)

