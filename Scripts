import glob

def tab_delim(lines, id):
	outfile = '../Results/' + id + '.parsed.txt'
	outfile = open(outfile, 'w')
	outfile.write('chr' + '\t' + 'first' + '\t' + 'last' + '\t' + 'span' + 
		 '\t' + 'minsum' + '\t' + 'maxsum' + '\t' + 'phased' + '\t' + 'len' + '\n')
	min=0
	max=0
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
				min += int(cols[1])
				max += int(cols[2])
				chr = cols[3]
				last = cols[4]
		
		elif '********' in line:
			# write the line for the last block
			first = int(last) - int(span)
			outfile.write(str(chr) + '\t' + str(first) + '\t' + str(last) + '\t' +
				str(span) + '\t'+ str(min) + '\t' + str(max) + '\t' + str(phased) +
				'\t' + str(len) + '\n')
			
			#reset the sums
			min=0
			max=0
	
	# write line for last block in file
        first = int(last) - int(span)
        outfile.write(str(chr) + '\t' + str(first) + '\t' + str(last) + '\t' +
		str(span) + '\t'+ str(min) + '\t' + str(max) + '\t' + str(phased) +
		'\t' + str(len))

	outfile.close()


#############################################
# Begin script
#############################################

# grab all hapcut files
files = glob.glob('../Data/*hapcut')

for file in files:
	# get infile info
	path = str(file)
	infile = open(path, 'r')
	lines = infile.readlines()
	
	#parse out name of indiv for outfile name
	id = file.split('/')[2]

	#run the module
	tab_delim(lines, id)
	
	infile.close()
