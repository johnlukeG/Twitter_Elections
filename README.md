# TwittaFingas
Using Tweets and Sentiment Analysis to determine the effect of positive and negative social media exposure on the outcome of Primary Elections.

## Authors

  * JL Garofalo
  * Daniel Hernandez
  * Matthew Lollis
  
## Source Files

  * PrimaryPredictor.R
      *   R Script that takes the tweets and analyzes their sentiment, then applies the model used to determine the outcome of the primary election.
         
  * Kafka Producer.py
      *   Python Script that mines Twitter based on a certain token word. We use this to gather the data prior to a primary, then we analyze the tweets using the PrimaryPredictor.R script.
