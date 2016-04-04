
# coding: utf-8

# In[1]:

import sys
import logging
import json

from kafka.client import KafkaClient
from kafka.producer import SimpleProducer
from datetime import datetime

from TwitterAPI import TwitterAPI


# In[2]:

#keyFile = open(".cert/Twitter")
#CONSUMER_KEY = keyFile.readline().rstrip()
#CONSUMER_SECRET = keyFile.readline().rstrip()
#ACCESS_TOKEN_KEY = keyFile.readline().rstrip()
#ACCESS_TOKEN_SECRET = keyFile.readline().rstrip()

CONSUMER_KEY = "qSLH1TKClLcPFa4veNL68KyTi"
CONSUMER_SECRET = "85W8sEXBUWF9dLl4GFSuR9KcY03bpIK79t3J26RVUVnJBzJaUY"

ACCESS_TOKEN_KEY = "43951254-RYFkJ5kQSkazNPj0aJO5jDSzP33IHjQwZ6MeOSkfU"
ACCESS_TOKEN_SECRET = "qSglieTlE2Ol0bCDFQNTFuOwt1cCm4iZicz0Kz8tdH9KK"

# print(CONSUMER_KEY)
# print(CONSUMER_SECRET)
# print(ACCESS_TOKEN_KEY)
# print(ACCESS_TOKEN_SECRET)


# In[3]:

api = TwitterAPI(CONSUMER_KEY,
                 CONSUMER_SECRET,
                 ACCESS_TOKEN_KEY,
                 ACCESS_TOKEN_SECRET)

TRACK_TERM = "Kasich"
r = api.request('statuses/filter', {'track': TRACK_TERM})


# In[4]:

kafka = KafkaClient("dsci004.palmetto.clemson.edu:6667")
producer = SimpleProducer(kafka)
TOPIC = "testTwitter"
i=1
for item in r:
  if 'text' in item:
    #print(str(i) + " " + item['text'])
    print(str(i) + " " + str(item['id']) + " " + str(item['text'].encode("utf-8")))
    Tweet_content = str(i) + " " + str(item['text'].encode("utf-8"))
#    producer.send_messages(TOPIC, Tweet_content + str(datetime.now().time()) )
    # sending full Tweet
    producer.send_messages(TOPIC, json.dumps(item))
    i += 1


# In[ ]:



