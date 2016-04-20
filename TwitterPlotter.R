library(ISLR)
library(bitops)
library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(quanteda)

candidates <- matrix(c("Sanders", "Trump", "Cruz", "Clinton", 0.2637925, 0.6526159, 0.3163926, 0.27047555, 0.2570602, 0.1496096, 0.27206695, 0.29553685, 0.2306007614, 0.5950462619, 0.06052553254, 0.1138713375, 0.47, .415, 0.285, 0.53, .42, .6, .15, .58), nrow=4, ncol=6)
candidates

# plot(lm(sanders[,1] ~ sanders[,2] + sanders[,3] + sanders[,4]))
plot(candidates[,2], candidates[,5], xlab="Positive Sentiment Tweet Ratio", ylab="Opinion Poll Results Ratio", main="Positive Sentiment Tweet Ratio vs. Opinion Poll Results", col=c("black","blue","red","green"))
model <- lm(candidates[,5] ~ as.numeric(candidates[,2]))
summary(model)
abline(model, col="red")
#Sanders = black, Trump = blue, Cruz = Red, Clinton = Green

plot(candidates[,3], candidates[,5], xlab="Negative Sentiment Ratio", ylab="Poll Results Ratio", main="Negative Sentiment vs. Poll Results", col=c("black","blue","red","green"))
model <- lm(candidates[,5] ~ as.numeric(candidates[,3]))
summary(model)
abline(model, col="red")

plot(candidates[,4], candidates[,5], xlab="Total Tweet Ratio", ylab="Opinion Poll Results Ratio", main="Total Tweet Ratio vs. Opinion Poll Results", col=c("black","blue","red","green"))
model <- lm(candidates[,5] ~ as.numeric(candidates[,4]))
summary(model)
abline(model, col="red")

#NY Primary Results
plot(candidates[,2], candidates[,6], xlab="Positive Sentiment Tweet Ratio", ylab="NY Primary Results Ratio", main="Positive Sentiment Tweet Ratio vs. NY Primary Results", col=c("black","blue","red","green"))
model <- lm(candidates[,6] ~ as.numeric(candidates[,2]))
summary(model)
abline(model, col="red")


plot(candidates[,4], candidates[,6], xlab="Total Tweet Ratio", ylab="NY Primary Results Ratio", main="Total Tweet Ratio vs. NY Primary Results", col=c("black","blue","red","green"))
model <- lm(candidates[,6] ~ as.numeric(candidates[,4]))
summary(model)
abline(model, col="red")
