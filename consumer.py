###########################################################################
## Authors ::
##     Skeleton Code provided by Dr.Linh Ngo
##     Modified by JL Garofalo
## Date    :: 04-14-2016
## Purpose :: This script is a kafka consumer that consumes tweets, encodes
##            them into JSON objects, and filters them based on the four 
##            major candidates in the 2016 Presidential Primary race. It's
##            consuming from a Kafka producer hosted on the Palmetto 
##            Supercomputer.
###########################################################################
## Command to run on clemson network: 
#      python consumer.py dsci002.palmetto.clemson.edu:6667 ElectionTwitter

import sys
import logging
import json
import ast

from kafka import KafkaConsumer

#logging.basicConfig(
#  format='%(asctime)s.%(msecs)s:%(name)s:%(thread)d:%(levelname)s:%(process)d:%(message)s',
#  level=logging.DEBUG
#)

if len(sys.argv) != 3:
  print("Usage: producer.py <broker:port> <topic>")
  print("Note: use port 9092 for default Kafka broker and 6667 for HDP Kafka broker")
  exit(-1)

consumer = KafkaConsumer(bootstrap_servers=sys.argv[1], auto_offset_reset='latest')
consumer.subscribe([sys.argv[2]])

print("Start consuming ...")

# Open files for writing
trumpFP = open("trumpTweets.txt", 'w')
clintonFP = open("clintonTweets.txt", 'w')
sandersFP = open("sandersTweets.txt", 'w')
cruzFP = open("cruzTweets.txt", 'w')

# File Pointers to write to for each candidate
filePointers = { 
              "trump":trumpFP, 
              "clinton":clintonFP,
              "sanders":sandersFP,
              "cruz":cruzFP
            }

def containsKeyword(keyword, fullText):
  """ Check Tweet for Keyword
        Keyword Arguments:
          keyword: Keyword substring to be checked
          fullText: Container string to be checked

        Returns: int
          1: if keyword is contained in fullText
          0: if keyword isn't contained in fullText

        Purpose:
          To check if a keyword is contained in a container string *CASE-INSENSITIVE*
  """
  if keyword.lower() in fullText.lower():
    return 1
  else:
    return 0


def filterTweet(tweet):
  """ Filter Tweet based on Candidate
        Keyword Arguments:
          tweet: Text of tweet to be filtered

        Purpose:
          Filters tweets that mention only one candidate in the body of its text and writes it to its respective file.
  """
  candidates = []
  if containsKeyword("trump", tweet):
    candidates.append("trump")
  if containsKeyword("clinton", tweet):
    candidates.append("clinton")
  if containsKeyword("sanders", tweet):
    candidates.append("sanders")
  if containsKeyword("cruz", tweet):
    candidates.append("cruz")

  if len(candidates) == 1 :
    if candidates[0] in filePointers.keys():
      print(candidates[0])

      fileToWriteTo = filePointers[candidates[0]]
      # delimit tweets with ` character
      fileToWriteTo.write(tweet+"`")

# Consume tweets and filter through them
counter = 0
for message in consumer:
  e = json.loads(json.loads(message.value.encode('utf-8')))
  counter = counter + 1
  print ("Tweet: " + counter)
  if u'text' in e:
    myText = e[u'text'].encode('utf-8')
    filterTweet(myText)
  else:
    print ("Hit rate limit ...")
  print("======== \n")

# Close all the file pointers
for key in filePointers:
  filePointers[key].close()



