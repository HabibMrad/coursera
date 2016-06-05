#The program will prompt for a URL, read the JSON data from that URL using urllib
#and then parse and extract the comment counts from the JSON data,
#compute the sum of the numbers in the file

#author: Chen Lu
import json
import urllib

url = raw_input('Enter location: ')
uh = urllib.urlopen(url)
data = uh.read()
print 'Retrieved',len(data),'characters'

info = json.loads(data)

# print comments
"""
for item in info['comments']:
    print 'Name', item['name']
    print 'count', item['count']
"""
print sum(int(item['count']) for item in info['comments'])
