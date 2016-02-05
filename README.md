# hapcut

Use hapcut reads from _C. grandiflora_ aligned to _C. rubella_ to see if long stretches of blocks contain reference geno

### Data
* vcfs and bam files needed to run hapcut on standout individuals -- get from wei
* other indivs to parse and plot are on capsicum in /data/ in wei's folder youngwha

### Scripts
* `min_sum.py` takes the hapcut output, parses, sums alt and ref alleles for each block, and tab-deliminates output
* `hap_plot.R` has the code to plot the span of a block against the sum of the minor? allele binary values in that block

### Results
* 3 FEB 2016: ran `min_sum.py` on our 8 test files
	* 27, 28, 87, 100, 101, 102, 107, 196
* 4 FEB 2016: plotted hapcut results & highlighted blocks containing part of the putative FT locus
	* plots in `haps.pdf`	

### To Do:
* run hapcut on full 196 dataset, parse, and plot
