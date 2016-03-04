import argparse

def arguments():
        parser = argparse.ArgumentParser(description="Program to take hapcut output and return various forms of the minsum metric. Must supply at least one of -r, -m, -w")
        parser.add_argument("-i", "--input", help="path to hapcut file", required=True)
        parser.add_argument('-o', '--output', help='output path with file name omitted. file name will be the input file name.', required=True)
        parser.add_argument('-w', '--windowsize', help='size of window in bp', type=int)
        parser.add_argument('-r', '--runs', help='use this flag to run runs of reference minsum', action='store_true')
        parser.add_argument('-m', '--minsum', help='use this flag to run minsum', action='store_true')
        args = parser.parse_args()
        return(args)

def minsum(lines, id, outpath):
	outfile = outpath + id + '.minsum'
	outfile = open(outfile, 'w')
	outfile.write('chr' + '\t' + 'first' + '\t' + 'last' + '\t' + 'span' + 
		 '\t' + 'minsum' + '\t' + 'maxsum' + '\t' + 'phased' + '\t' + 'len' + '\n')
	min=0
	max=0
	hap1=0
	hap2=0
	last = lines[-1]

	for line in lines:

		# the ***** lines are just spacers, so we don't care about them
		if '********' not in line:
			# check if BLOCK line---this means we need length data
			if 'BLOCK' in line:
				# split line into vector of options
				colsplit = line.split(' ')
				# we want the length of the block, the number of indivs, and the span of the block
				len = colsplit[4]
				phased = colsplit[6]
				span = 	colsplit[8]
			
			# add check for the correct number of columns---exit with error if this is the case
#			elif len(line.split('\t')) != 9:
#				quit(1)

			# only other lines should be tab-deliminated data---get the rest of the info and iteratively add sums
			else:
				cols = line.split()
				hap1 += int(cols[1])
				hap2 += int(cols[2])
				chr = cols[3]
				last = cols[4]
		
		elif '********' in line:
			# write the line for the last block
			if hap1 > hap2:
				min = hap2 
				max = hap1
			else:
				min = hap1
				max = hap2
			first = int(last) - int(span)
			outfile.write(str(chr) + '\t' + str(first) + '\t' + str(last) + '\t' +
				str(span) + '\t'+ str(min) + '\t' + str(max) + '\t' + str(phased) +
				'\t' + str(len) + '\n')
			
			#reset the sums
			hap1=0
			hap2=0
			min=0
			max=0
	
	# write line for last block in file
        first = int(last) - int(span)
        outfile.write(str(chr) + '\t' + str(first) + '\t' + str(last) + '\t' +
		str(span) + '\t'+ str(min) + '\t' + str(max) + '\t' + str(phased) +
		'\t' + str(len))

	outfile.close()

def runsofrub(lines, id, outpath):
        outfile = outpath + id + '.minruns'
        outfile = open(outfile, 'w')
        outfile.write('chr' + '\t' + 'start' + '\t' + 'end' + '\t' + 'snps' + '\t' + 'haplotype' + '\n')
	
	hap1run=0
	hap2run=0
	
	for line in lines:

		colsplit = line.split()
		
		# we really only need the lines with actual information
		# don't need metadata from BLOCK line for this metric
		if '********' not in line and 'BLOCK' not in line:
			
			# split line into vector of options
			hap1 = int(colsplit[1])
			hap2 = int(colsplit[2])
			if hap1run==0:
	                	hap1end=int(colsplit[4])
				hap1start = int(colsplit[4])
			if hap2run==0:
	                	hap2end=int(colsplit[4])
				hap2start = int(colsplit[4])
			if hap1==0:
				chr = colsplit[3]
	                	hap1end=int(colsplit[4])
				hap1run+=1
			else:
				if hap1run>0:
					outfile.write(str(chr) + '\t' + str(hap1start) +
						'\t' + str(hap1end) + '\t' + str(hap1run) +
						'\t' + '1' + '\n')
				hap1run = 0

			if hap2==0:
				chr = colsplit[3]
	                	hap2end=int(colsplit[4])
				hap2run+=1
                        else:    
                                if hap2run>0:
                                        outfile.write(str(chr) + '\t' + str(hap2start) +
                                                '\t' + str(hap2end) + '\t' + str(hap2run) + 
                                                '\t' + '2' + '\n')
				hap2run = 0

                elif '********' in line:
                        # write the line for the last block
			if hap1run>0:
                                outfile.write(str(chr) + '\t' + str(hap1start) +
                                        '\t' + str(hap1end) + '\t' + str(hap1run) +
                                        '\t' + '1' + '\n')
                        hap1run = 0

                        if hap2run>0:
                                outfile.write(str(chr) + '\t' + str(hap2start) +
                                        '\t' + str(hap2end) + '\t' + str(hap2run) +
                                        '\t' + '2' + '\n')
                        hap2run = 0
	
	if hap1run>0:
                outfile.write(str(chr) + '\t' + str(hap1start) +
                        '\t' + str(hap1end) + '\t' + str(hap1run) +
                        '\t' + '1' + '\n')
        if hap2run>0:
                outfile.write(str(chr) + '\t' + str(hap2start) +
                        '\t' + str(hap2end) + '\t' + str(hap2run) +
                        '\t' + '2' + '\n')
	outfile.close()		

#############################################
# Begin script
#############################################

args = arguments()

# get infile info
input = args.input
infile = open(input, 'r')
lines = infile.readlines()

# get outpath info
outpath = args.output

#parse out name of indiv for outfile name
id = input.split('/')[-1]

#run the minsum module if specified
if args.minsum:
	print 'running minsum'
	minsum(lines, id, outpath)
	print 'minsum finished'

# only run the runs of rubellaness module if specified
if args.runs:
	print 'running runs of rubellaness'
	runsofrub(lines, id, outpath)
	print 'runs of rubellaness finished'

#only run windowed module if specified windowsize
#if args.windowsize:
	
infile.close()
