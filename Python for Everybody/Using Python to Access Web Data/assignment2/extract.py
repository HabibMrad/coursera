#Extracting Data With Regular Expressions

#In this assignment you will read through and parse a file with text and numbers.
#You will extract all the numbers in the file and compute the sum of the numbers.

#author: Chen Lu
import re

#solution 1
"""
name = raw_input("Enter file:")
hand = open(name, "r")
read = hand.read()
nums = re.findall('[0-9]+', read)
nums = [int(i) for i in nums]
total = sum(nums)
print total
"""

#compact solution
print sum( [int(i) for i in re.findall('[0-9]+', open(raw_input("Enter file: ")).read()) ] )
