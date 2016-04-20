# Twitter_Elections
Using Tweets and Sentiment Analysis to determine the effect of positive and overall twitter exposure on the outcome of preliminary opinion polls and state primary elections.

## Authors

&copy; Copyright 2016 *ALL RIGHTS RESERVED*

  * John Lucas Garofalo
  * Daniel Hernandez
  * Matthew Lollis
  * Dr. Alexander Herzog
  * Dr. Linh Ngo
  
## Source Files

  * PrimaryPredictor.R
      *   R Script that cleans, the tweets and analyzes their sentiment, then applies the linear regression method model used to determine the positive sentiment ratio and total tweet ratio of each candidate.

  * TwitterPlotter.R
      *   R Script that plots the data created from *PrimaryPredictor.R* for the positive sentiment ratio and total tweet ratio of each candidate.

  * consumer.pbs
      *   PBS bash script that requests resources from the palmetto supercomputer and specifies details such as run (wall) time, number of resource nodes, and memory allocation. This allows us to run the *consumer.py* script on the supercomputer over an extended period of time.

  * consumer.py
      *   Python script that consumes from the Kafka Producer. In our case, we used the Palmetto supercomputer to run our producer and this script. It consumes tweets and filters them based on each of the four main candidate's last name, then writes the tweet to its respective txt file. It delimits each tweet with a '`' character.
         
  * Kafka Producer.py
      *   Python Script that mines Twitter based on a certain token word. We use this to gather the data prior to a primary, then we analyze the tweets using the PrimaryPredictor.R script.


## CPSC 4820: Data Science Project Poster
### Spring 2016 
![alt text][logo]

[logo]: https://github.com/JLGarofal/Twitter_Elections/blob/master/Twitter_Exposure_Elections.png "CPSC 4820 Data Science Project Poster"
