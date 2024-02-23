"""
Script to parse through the Virus-Host DB database and extract only viral 
pathogens that infect non-humans and write into TSV file.
Jennifer Gilby, Dr. Cynthia Gibas & Dr. Jessica Schlueter Lab UNC Charlotte

"""

import os
def DBParser(fh, tax_ids):

		for line in fh:

			fields = line.strip().split('\t') # split tsv into field elements
			
			virus_tax_id = fields[0]
			virus_name= fields[1] 
			host_tax_id = fields[2] 
			host_name = fields[3] 

			i = 0
			for taxID in tax_ids:
				i+=1
				if taxID == virus_tax_id:
					print('hit')
					tax_id = fields[0]
					virus_name = fields[1]
					host_name = fields[3]
					yield tax_id, virus_name, host_name




def main():
	
	output_file = "non-human-viruses.tsv"

	# create list of pathogen tax ids in our samples 
	with open("braken_non-human.tsv", 'r') as fh: # this is correct, 914 tax ids
		tax_ids = []
		for line in fh:
			line = line.strip().split('\t')
			for i in range(len(line)):
				if i % 2 != 0: # odd number are tax id, even is name
					tax_ids.append(line[i])
	# print(tax_ids)

	
	# open write out file
	with open(output_file, 'w') as fout:

		# open viral DB
		with open("non-human-DB.tsv", 'r') as fh:
			
			for line in fh:

				fields = line.strip().split('\t') # split tsv into field elements
				
				
				virus_tax_id = fields[0]
				virus_name= fields[1] 
				host_tax_id = fields[2] 
				host_name = fields[3] 

				# iterate through list of tax_ids in our data 
				i = 0
				for taxID in tax_ids:

					i+=1
					if taxID == virus_tax_id:
						print('hit')
						tax_id = fields[0]
						virus_name = fields[1]
						host_name = fields[3]

						# write hit into out file 
						fout.write(tax_id + '\t')
						fout.write(virus_name + '\t')
						fout.write(host_name + '\t')
						fout.write('\n')
						print('File updated.')
		print('Non-human virus file written. Program quitting...')
				


if __name__ == '__main__':
	main()
