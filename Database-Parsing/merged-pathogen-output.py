"""
Script to merge output from all database parsing scripts and compare to species 
identified in our wastewater metagenome. Write out a TSV file. 
Jennifer Gilby, Dr. Cynthia Gibas & Dr. Jessica Schlueter Lab UNC Charlotte

"""

def main():

	output_file = "waterwater-nonhuman-pathogens.tsv"
	
	# all non human tax ids from all parsers in a list 
	tax_id_list = []

	# open write out file
	with open(output_file, 'w') as fout:

		# bacterial avian paths 
		with open("avian-bacteria.tsv", 'r') as fh:
			for line in fh:
				line = line.strip().split('\t')
				if line[0] in tax_id_list:
					pass
				else:
					tax_id_list.append(line[0])

		# bacterial plant paths 
		with open("plant-bacteria.tsv", 'r') as fh:
			for line in fh:
				line = line.strip().split('\t')
				if line[0] in tax_id_list:
					pass
				else:
					tax_id_list.append(line[0])

		# bacterial NH mammal paths 
		with open("NHMammal-bacteria.tsv", 'r') as fh:
			for line in fh:
				line = line.strip().split('\t')
				if line[0] in tax_id_list:
					pass
				else:
					tax_id_list.append(line[0])

		# viral paths 
		with open("non-human-viruses.tsv", 'r') as fh:
			for line in fh:
				line = line.strip().split('\t')
				if line[0] in tax_id_list:
					pass
				else:
					tax_id_list.append(line[0])

		# create list of pathogen tax ids in our samples 
		i = 0
		for tax_id in tax_id_list:
			print('searching for match for ' + tax_id)

			with open("merged_bracken_output.tsv", 'r') as fh: # this is correct, 914 tax ids
				for line in fh:
					species = line.strip().split('\t')					
					
					if tax_id == species[1]: 
						
						for j in species:
							fout.write(j + '\t')
						fout.write('\n')
						print('non-human record found. adding to file...')
						i +=1 
					
					else:
						pass
			
		print(str(i) + ' records found and written to file. Program quitting...')



if __name__ == '__main__':
	main()
