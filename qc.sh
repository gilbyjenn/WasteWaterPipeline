#!/bin/bash 

#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36
#SBATCH --mail-user=jgilby@uncc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64GB
#SBATCH --job-name=QC_reads
#SBATCH --partition=Orion

module load fastqc

SOFTWARE="/scratch/jgilby/utilities"

sample_dir="/users/jgilby/viromeProject"
fastqs_dir="${sample_dir}/trimmed_fastqs"
outdir="${sample_dir}/QC"
mkdir -p ${outdir}

for i in `ls $fastqs_dir/* | grep R1`

do
 echo "QCing  $i"

name=`basename $i | cut -d_ -f1-3`

fastqc ${fastqs_dir}/WW_paired/"${name}"_R1_paired.fastq.gz ${fastqs_dir}/WW_paired/"${name}"_R2_paired.fastq.gz

done
