library(ISLR)
library(bitops)
library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(quanteda)
# 
# sanders <- matrix(c(1,2,0.2344158,0.2931692, 0.2374362, 0.2766842, 0.256400889, 0.2048006338, .49, .45), nrow=2, ncol=5)
# trump <- matrix(c(1,2,0.6178285,0.6874033, 0.1000708, 0.1991484, 0.5510507255, 0.6390417982, .4, .43), nrow=2, ncol=5)
# cruz <- matrix(c(1,2,0.3377648,0.2950204, 0.2626514, 0.2814825, 0.06581490189, 0.05523616319, .35, .22), nrow=2, ncol=5)
# clinton <- matrix(c(1,2,0.2748298,0.2661213, 0.3154153, 0.2756584, 0.1268212702, 0.1009214048, .51, .55), nrow=2, ncol=5)

candidates <- matrix(c("Sanders", "Trump", "Cruz", "Clinton", 0.2637925, 0.6526159, 0.3163926, 0.27047555, 0.2570602, 0.1496096, 0.27206695, 0.29553685, 0.2306007614, 0.5950462619, 0.06052553254, 0.1138713375, 0.47, .415, 0.285, 0.53), nrow=4, ncol=5)
candidates

# plot(lm(sanders[,1] ~ sanders[,2] + sanders[,3] + sanders[,4]))
plot(candidates[,2], candidates[,5], xlab="Positive Sentiment Ratio", ylab="Poll Results Ratio", main="Positive Sentiment vs. Poll Results", col=c("black","blue","red","green"))
model <- lm(candidates[,5] ~ as.numeric(candidates[,4]))
summary(model)
abline(model, col="red")
#Sanders = black, Trump = blue, Cruz = Red, Clinton = Green

plot(candidates[,3], candidates[,5], xlab="Negative Sentiment Ratio", ylab="Poll Results Ratio", main="Negative Sentiment vs. Poll Results", col=c("black","blue","red","green"))
model <- lm(candidates[,5] ~ as.numeric(candidates[,3]))
summary(model)
abline(model, col="red")

plot(candidates[,4], candidates[,5], xlab="Total Tweet Ratio", ylab="Poll Results Ratio", main="Total Tweets vs. Poll Results", col=c("black","blue","red","green"))
model <- lm(candidates[,5] ~ as.numeric(candidates[,4]))
summary(model)
abline(model, col="red")

