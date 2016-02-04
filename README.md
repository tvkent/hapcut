# hapcut

Use hapcut reads from _C. grandiflora_ aligned to _C. rubella_ to see if long stretches of blocks contain reference geno

### Data
* vcfs and bam files needed to run hapcut on standout individuals -- get from wei
* other indivs to parse and plot are on capsicum in /data/ in wei's folder youngwha

### Scripts
* `min_sum.py` takes the hapcut output, parses, sums alt and ref alleles for each block, and tab-deliminates output

### Results
* 3 FEB 2016: ran `min_sum.py` on our 8 test files
	* 27, 28, 87, 100, 101, 102, 107, 196

### To Do:
* plot SNPs, length, and SNPs/length by the min sum of 1's in hap block for test 8
* run hapcut on full 196 dataset, parse, and plot
