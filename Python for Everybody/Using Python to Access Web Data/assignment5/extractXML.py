#The program will prompt for a URL, read the XML data from that URL using urllib
#and then parse and extract the comment counts from the XML data,
#compute the sum of the numbers in the file and enter the sum

#author: Chen Lu
import urllib
import xml.etree.ElementTree as ET

url = raw_input('Enter location: ')
uh = urllib.urlopen(url)
data = uh.read()
print 'Retrieved',len(data),'characters'
tree = ET.fromstring(data)

counts = tree.findall('.//count')

nums = [int(count.text) for count in counts]
print "Count: ", len(counts)
print "Sum: ", sum(nums)
