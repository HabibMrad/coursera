#Following Links in HTML Using BeautifulSoup

#The program will use urllib to read the HTML from the data files below,
#extract the href= vaues from the anchor tags,
#scan for a tag that is in a particular position from the top and follow that link,
#repeat the process a number of times, and report the last name you find.

#author: Chen Lu
html = urllib.urlopen(url).read()

import urllib
from BeautifulSoup import *

url = raw_input('Enter - ')
count = int(raw_input('Enter count: '))
position = int(raw_input('Enter position: '))

html = urllib.urlopen(url).read()
soup = BeautifulSoup(html)

for i in range(count):
    tags = soup('a')
    tags = list(tags)
    url = tags[position-1].get('href', None)
    print tags[position-1].contents[0]
    html = urllib.urlopen(url).read()
    soup = BeautifulSoup(html)
