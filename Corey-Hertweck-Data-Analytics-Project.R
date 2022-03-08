install.packages("faraway")
library(faraway)
debt
dataset_debt.new <- na.omit(debt)
dataset_debt.new
summary(dataset_debt.new)

dataset_debt.new$singpar <- as.factor(dataset_debt.new$singpar)
dataset_debt.new$agegp <- as.factor(dataset_debt.new$agegp)
dataset_debt.new$incomegp <- as.factor(dataset_debt.new$incomegp)
dataset_debt.new$house <- as.factor(dataset_debt.new$house)
dataset_debt.new$bankacc <- as.factor(dataset_debt.new$bankacc)
dataset_debt.new$bsocacc <- as.factor(dataset_debt.new$bsocacc)
dataset_debt.new$ccarduse <- as.factor(dataset_debt.new$ccarduse)
dataset_debt.new$cigbuy <- as.factor(dataset_debt.new$cigbuy)
dataset_debt.new$xmasbuy <- as.factor(dataset_debt.new$xmasbuy)

summary(dataset_debt.new)
str(dataset_debt.new)

library(tidyverse)
library(dplyr)
library(ggplot2)
ggplot(data = dataset_debt.new)
as_tibble(dataset_debt.new)

library(GGally)

dataset_debt.new %>% select(1:13)
ggpairs(data = dataset_debt.new, columns = c(1:13))

ggplot(data = dataset_debt.new) + geom_point(mapping = aes(x = children, y = prodebt))
ggplot(data = dataset_debt.new) + geom_col(mapping = aes(x = locintrn, y = prodebt))
ggplot(data = dataset_debt.new) + geom_col(mapping = aes(x = children, y = prodebt))
ggplot(data = dataset_debt.new) + geom_col(mapping = aes(x = manage, y = prodebt))
ggplot(data = dataset_debt.new) + geom_col(mapping = aes(x = manage, y = locintrn))
ggplot(data = dataset_debt.new) + geom_point(mapping = aes(x = manage, y = prodebt))

ggplot(data = dataset_debt.new) + 
  stat_count(mapping = aes(x = singpar))

ggplot(data = dataset_debt.new) + 
  stat_count(mapping = aes(x = agegp))




#Analysis  
lmobj.6 <- lm(prodebt ~ locintrn, dataset_debt.new)
print(summary(lmobj.6))

lmobj.7 <- lm(prodebt ~ locintrn + manage, dataset_debt.new)
print(summary(lmobj.7))

lmobj.8 <- lm(prodebt ~ locintrn + manage + children, dataset_debt.new)
print(summary(lmobj.8))

print(anova(lmobj.6, lmobj.7, lmobj.8))

lmobj.9 <- lm(prodebt ~ locintrn + manage + children + singpar, dataset_debt.new)
print(summary(lmobj.9))

lmobj.10 <- lm(prodebt ~ locintrn + manage + children + singpar + agegp, dataset_debt.new)
print(summary(lmobj.10))


























