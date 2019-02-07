#!/usr/bin/env python

import sys
import re

norm_factor=float(sys.argv[1])
infile1=sys.argv[2]

bedgraph=open(infile1, 'r')
#output=open(outfile1, 'w')



for line in bedgraph.readlines():

    line=line.split()
    norm_score=float(line[3])/(float(norm_factor/1000000))		
    print str(line[0]+"\t"+line[1]+"\t"+line[2]+"\t"+str(norm_score))


