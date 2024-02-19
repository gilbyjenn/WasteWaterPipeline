#!/bin/bash 

#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36
#SBATCH --mail-user=jgilby@uncc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64GB
#SBATCH --job-name=trimRawFastqs
#SBATCH --partition=Orion

module load trimmomatic

SOFTWARE="/scratch/jgilby/utilities/Trimmomatic-0.39"
ADAPTERS = “${SOFTWARE}/adapters”

sample_dir="/users/jgilby/viromeProject"
fastqs_dir="${sample_dir}/raw_fastqs"
outdir="${sample_dir}/trimmed_fastqs"


for i in `ls $fastqs_dir/* | grep R1`

do
 echo "Trimming  $i"

name=`basename $i | cut -d_ -f1-3`

java -jar ${SOFTWARE}/trimmomatic-0.39.jar PE ${fastqs_dir}/"${name}"_R1_001.fastq.gz ${fastqs_dir}/"${name}"_R2_001.fastq.gz ${outdir}/"${name}"_R1_paired.fastq.gz ${outdir}/"${name}"_R1_unpaired.fastq.gz ${outdir}/"${name}"_R2_paired.fastq.gz ${outdir}/"${name}"_R2_unpaired.fastq.gz ILLUMINACLIP:${SOFTWARE}/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

done
