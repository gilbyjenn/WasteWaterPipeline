"""
Script to parse through the Bacterial and Viral Bioinformatics Resource Center (BV-BRC)
database and extract only bacterial pathogens that infect birds and write into TSV file.
Jennifer Gilby, Dr. Cynthia Gibas & Dr. Jessica Schlueter Lab UNC Charlotte

"""


def main():
	
	output_file = "avian-bacteria.tsv"

	# create list of pathogen tax ids in our samples 
	with open("braken_non-human.tsv", 'r') as fh: 
		tax_ids = []
		for line in fh:
			line = line.strip().split('\t')
			for i in range(len(line)):
				if i % 2 != 0: # odd number are tax id, even is name
					tax_ids.append(line[i])
	# test code
	# print(tax_ids)

	
	# open write out file
	with open(output_file, 'w') as fout:

		# open bacterial DB
		with open("avianDB.tsv", 'r') as fh:
			hits = 0
			for line in fh:

				fields = line.strip().split('\t') # split tsv into field elements

				bact_tax_id = fields[0]
				bact_name= fields[1] 
				host_name = fields[2]


				for taxID in tax_ids:
					if taxID == bact_tax_id:
						print('hit')
						hits += 1
						tax_id = fields[0]
						bact_name = fields[1]
						host_name = fields[2]

						# write hit into out file 
						fout.write(tax_id + '\t')
						fout.write(bact_name + '\t')
						fout.write(host_name + '\t')
						fout.write('\n')
						print('File updated.')
		print('Avian bacterial pathogens file written. ' + str(hits) + ' pathogens found. Program quitting...') 


if __name__ == '__main__':
	main()