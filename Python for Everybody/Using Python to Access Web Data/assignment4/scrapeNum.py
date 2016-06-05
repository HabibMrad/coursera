#Scraping Numbers from HTML using BeautifulSoup

#The program will use urllib to read the HTML from the data files below,
#and parse the data, extracting numbers and compute the sum of the numbers in the file.

#author: Chen Lu

import urllib
from BeautifulSoup import *
import re

url = raw_input('Enter - ')
html = urllib.urlopen(url).read()
soup = BeautifulSoup(html)
nums = []

# Retrieve all of the anchor tags
tags = soup('span')
for tag in tags:
   # Look at the parts of a tag
   #print 'TAG:',tag, str(tag)
   nums = nums + re.findall('[0-9]+', str(tag))
nums = [int(i) for i in nums]
print sum(nums)
