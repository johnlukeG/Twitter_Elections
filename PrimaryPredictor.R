##  Author   :: JL Garofalo
##           :: Daniel Hernandez
##           :: Matthew Alan Lollis
##  Date     :: 3-31-2016
##  Purpose  :: Analyzing Text
##--------------------------------------------

## 1. Preparation
# Erase workspace to clean
rm(list = ls())

# Install necessary packages
# install.packages("bitops")
# install.packages("twitteR")
# install.packages("RCurl")
# install.packages("RJSONIO")
# install.packages("stringr")

# Import necessary libraries
library(ISLR)
library(bitops)
library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(quanteda)

# Save Datumbox API Information
Datum.UserID <- "6746"
Datum.APIKey <- "3e68babb633d3bf80ed22b55345f068b"
Datum.SubID  <- "6731"

## 2. Functions
#---------------------------------------------------------------------------------------------------
# Function: clean.text
# Purpose : We need this function because of the problems occurring when the tweets contain some 
#           certain characters and to remove characters like “@” and “RT”
# Source  : http://www.r-bloggers.com/sentiment-analysis-on-twitter-with-datumbox-api/
#---------------------------------------------------------------------------------------------------
clean.text <- function(some_txt)
{
  some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
  some_txt = gsub("@\\w+", "", some_txt)
  some_txt = gsub("([`|'])|[[:punct:]]", "\\1", some_txt)
#  some_txt = gsub("[[:punct:]]", "", some_txt)
  some_txt = gsub("http\\w+", "", some_txt)
  some_txt = gsub("[[:digit:]]", " ", some_txt)
  #some_txt = gsub("[ \t]{2,}", "", some_txt)
  #some_txt = gsub("^\\s+|\\s+$", "", some_txt)
  some_txt = gsub("\n", " ", some_txt)
  some_txt = gsub("`", "\n", some_txt)
  some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
  
  # define "tolower error handling" function
  try.tolower = function(x)
  {
    y = NA
    try_error = tryCatch(tolower(x), error=function(e) e)
    if (!inherits(try_error, "error"))
      y = tolower(x)
    return(y)
  }
  
  some_txt = sapply(some_txt, try.tolower)
  some_txt = some_txt[some_txt != ""]
  names(some_txt) = NULL
  return(some_txt)
}


## Get results and perform sentiment analysis

# Set Positive and Negative Words
# Credit for documents:
# ;   Minqing Hu and Bing Liu. "Mining and Summarizing Customer Reviews." 
# ;       Proceedings of the ACM SIGKDD International Conference on Knowledge 
# ;       Discovery and Data Mining (KDD-2004), Aug 22-25, 2004, Seattle, 
# ;       Washington, USA, 
posWords <- readLines("positive-words.txt")
negWords <- readLines("negative-words.txt")

# Read in file and clean it up for sentiment analysis
fileName <- "sandersTweets.txt"
actFile <- readChar(fileName, file.info(fileName)$size)
cleanFile <- clean.text(actFile)
cleanFileCon <- textConnection(cleanFile)

Tweets <- read.table(cleanFileCon,sep="\n", quote="", row.names = NULL, stringsAsFactors = FALSE,fill=TRUE, header=FALSE)

posTweets <- 0
negTweets <- 0
neutTweets <- 0
posRatio <- 0
negRatio <- 0
neutTweets <- 0

# Read through every tweet and determine whether it was positive, negative, or neutral
for(i in unlist(Tweets)){
  word_list <- strsplit(i, " ")
  words <- unlist(word_list)
  positive_matches <- match(words, posWords)
  negative_matches <- match(words, negWords)
  positive_matches <- positive_matches[!is.na(positive_matches)]
  negative_matches <- negative_matches[!is.na(negative_matches)]
  score = sum(positive_matches) - sum(negative_matches)

  if(score > 0){
    posTweets <- posTweets + 1
  } else if(score < 0){
    negTweets <- negTweets + 1
  } else {
    neutTweets <- neutTweets + 1
  }
  
  
}

totalTweets <- sum(negTweets, posTweets, neutTweets, na.rm = TRUE)

#calculate ratios
posRatio <- posTweets / totalTweets
negRatio <- negTweets / totalTweets
neutRatio <- neutTweets / totalTweets





