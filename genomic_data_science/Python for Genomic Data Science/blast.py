#!/usr/bin/python

"""Running BLAST over the Internet"""

import Bio
from Bio.Blast import NCBIWWW
from Bio.Blast import NCBIXML

seq = "TGGGCCTCATATTTATCCTATATACCATGTTCGTATGGTGGCGCGATGTTCTACGTGAATCCACGTTCGAAGGACATCATACCAAAGTCGTACAATTAGGACCTCGATATGGTTTTATTCTGTTTATCGTATCGGAGGTTATGTTCTTTTTTGCTCTTTTTCGGGCTTCTTCTCATTCTTCTTTGGCACCTACGGTAGAG"
E_VALUE_THRESH = 1e-29

result_handle = NCBIWWW.qblast("blastn","nt",seq)
blast_record = NCBIXML.read(result_handle)

for alignment in blast_record.alignments:
	for hsp in alignment.hsps:
		if hsp.expect < E_VALUE_THRESH:
			print('****Alignment****')
			print('sequence:', alignment.title)
			print('length:', alignment.length)
			print('e value:', hsp.expect)
			

	