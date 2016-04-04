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
install.packages("bitops")
install.packages("twitteR")
install.packages("RCurl")
install.packages("RJSONIO")
install.packages("stringr")

# Import necessary libraries
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
# Function: getSentiment
# Purpose : handles the queries we send to the API. It saves all the results we want to have 
#           like sentiment, subject, topic and gender and returns them as a list. For every 
#           request we have the same structure and the API is always requesting the API-Key 
#           and the text to be analyzed. It then returns a JSON object of the structure
# Source  : http://www.r-bloggers.com/sentiment-analysis-on-twitter-with-datumbox-api/
#---------------------------------------------------------------------------------------------------
getSentiment <- function (text, key){
  
  text <- URLencode(text);
  
  #save all the spaces, then get rid of the weird characters that break the API, then convert back 
  #  the URL-encoded spaces.
  text <- str_replace_all(text, "%20", " ");
  text <- str_replace_all(text, "%\\d\\d", "");
  text <- str_replace_all(text, " ", "%20");
  
  
  if (str_length(text) > 360){
    text <- substr(text, 0, 359);
  }
  ##########################################
  
  data <- getURL(paste("http://api.datumbox.com/1.0/TwitterSentimentAnalysis.json?api_key=", key, "&text=",text, sep=""))
  
  js <- fromJSON(data, asText=TRUE);
  
  # get mood probability
  sentiment = js$output$result
  
  ###################################
  
  data <- getURL(paste("http://api.datumbox.com/1.0/SubjectivityAnalysis.json?api_key=", key, "&text=",text, sep=""))
  
  js <- fromJSON(data, asText=TRUE);
  
  # get mood probability
  subject = js$output$result
  
  ##################################
  
  data <- getURL(paste("http://api.datumbox.com/1.0/TopicClassification.json?api_key=", key, "&text=",text, sep=""))
  
  js <- fromJSON(data, asText=TRUE);
  
  # get mood probability
  topic = js$output$result
  
  ##################################
  data <- getURL(paste("http://api.datumbox.com/1.0/GenderDetection.json?api_key=", key, "&text=",text, sep=""))
  
  js <- fromJSON(data, asText=TRUE);
  
  # get mood probability
  gender = js$output$result
  
  return(list(sentiment=sentiment,subject=subject,topic=topic,gender=gender))
}

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
  some_txt = gsub("[[:punct:]]", "", some_txt)
  some_txt = gsub("[[:digit:]]", "", some_txt)
  some_txt = gsub("http\\w+", "", some_txt)
  some_txt = gsub("[ \t]{2,}", "", some_txt)
  some_txt = gsub("^\\s+|\\s+$", "", some_txt)
  
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


