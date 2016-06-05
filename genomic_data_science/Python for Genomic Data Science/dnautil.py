#!/usr/bin/python
# -*- coding: utf-8 -*-
import os, sys

def readFasta(filename):

    try:
        f = open(filename)
    except IOError:
        print("File myfile.fa does not exist!!")

    seqs = {}
    
    numOfRecords = 0
    
    for line in f:
        line = line.rstrip()
        if line[0] == '>':
            words = line.split()
            name = words[0][1:]
            seqs[name] = ''
            numOfRecords += 1
        else:
            seqs[name] = seqs[name]  + line

    f.close()
    
    print("This fasta file has %d records."%numOfRecords)
    
    return seqs

def seqLength(**seqs):

    #for name,seq in seqs.items():
        #print(name, len(seq))

    maxLen = 0
    for name,seq in seqs.items():
        if maxLen <= len(seq) :
            maxLen = len(seq)
            
    minLen = maxLen
    for name,seq in seqs.items():
        if minLen >= len(seq) :
            minLen = len(seq)
            
    minName = [] 
    maxName = []
    for name,seq in seqs.items():
        if len(seq) == maxLen:
            maxName.append(name)
        if len(seq) == minLen:
            minName.append(name)
        
    print("The longest sequence : %s;"%maxName,"it has %d bases."%maxLen)
    print("The shortest sequence : %s;"%minName,"it has %d bases."%minLen)

def reverse(seq):
    basecomplement = {'A':'T', 'C':'G','G':'C', 'T':'A', 'N':'N', 'a':'t', 'c':'g','g':'c', 't':'a', 'n':'n'}
    dna = seq[::-1]
    letters = [basecomplement[base] for base in  dna]
    return ''.join(letters)

def reverseSeqs(**seqs):
    reverseSeqs = {}
    for name,seq in seqs.items():
        id = name
        reverseSeqs[id] = reverse(seq)
    return reverseSeqs

def allFrames(dna,frame):
    
    start_codons = ['atg']
    stop_codons=['tga','tag','taa']
    ORF = {}
    stop = False
    current_position = frame

    while(current_position < len(dna) and not stop):
        
        start_position = current_position
        stop_position = current_position
        start_codon_found = False
        stop_codon_found = False
        
        for i in range(current_position, len(dna),3):
            codon = dna[i:i+3].lower()
            if codon in start_codons:
                start_codon_found = True
                start_position = i
                current_position = i
                break
    
        if start_codon_found:
            for j in range(current_position+3,len(dna),3):
                codon = dna[j:j+3].lower()
                if codon in stop_codons:
                    stop_codon_found = True
                    stop_position = j
                    current_position = j
                    break

        if start_codon_found and stop_codon_found:
            length = stop_position-start_position+3
            pos = start_position
            ORF[pos] = length
            current_position = current_position + 3
        else:
            stop = True

    return ORF


def readFrame(dna,frame):
    ORF = allFrames(dna,frame)
    frameRead = []
    if ORF == {}:
        frameRead = [0,0]
    else:
        maxLength = sorted(ORF.values())[-1]
        start = [position for position, length in ORF.items() if length == maxLength]
        frameRead = [maxLength,start]
    return frameRead

def longestFileFrame(frame,**seqs):
    fileORF = {}
    id_of_file = []
    for name, seq in seqs.items():
        id = name
        fileORF[id] = readFrame(seq,frame)[0]
    length = sorted(fileORF.values())[-1]
    id_of_file= [id for id, len in fileORF.items() if len == length]
    return length, id_of_file

def startPos(id, frame, **seqs):
    dna = seqs[id]
    frameRead = readFrame(dna,frame)
    return frameRead

def longestIdFrame(id,**seqs):
    dna = seqs[id]
    frame_for_longestORF = []
    idORF = {}
    for i in range(3):
        frame = i
        idORF[frame] = readFrame(dna,i)[0]
    length = sorted(idORF.values())[-1]
    frame_for_longestORF = [frame for frame, len in idORF.items() if len == length]

    return length, frame_for_longestORF

def allRepeats(n,**seqs):
    substrings = []
    repeats = {}
    for seq in seqs.values():
        for i in range(len(seq) - n + 1):
            r = seq[i:i+n]
            name = r
            if not r in substrings:
                substrings.append(r)
            elif r in substrings and r not in repeats:
                repeats[name] = 2
            else:
                repeats[name] += 1
    return repeats


def maxRepeats(n,**seqs):
    repeats = allRepeats(n,**seqs)
    max = sorted(repeats.values())[-1]
    maxRepeats = [name for name, freq in repeats.items() if freq == max]
    return max,maxRepeats






