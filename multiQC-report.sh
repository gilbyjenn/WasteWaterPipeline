#!/bin/bash 

#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36
#SBATCH --mail-user=jgilby@uncc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64GB
#SBATCH --job-name=mqc
#SBATCH --partition=Orion

module load anaconda3 
conda activate MultiQC 
multiqc /users/jgilby/viromeProject/trimmed_fastqs -n “multiQC_output” -o /users/jgilby/viromeProject/reports
