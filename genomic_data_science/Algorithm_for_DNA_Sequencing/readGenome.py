#!/usr/bin/python

#parses a DNA reference genome from a FASTA file

def readGenome(filename):
    genome = ‘’
    with open(filename,’r)as f:
        for line in f:
	    #ignore header line with genome information
	    if not line[0] == ‘>’:
		genome += line.rstrip()
    return genome