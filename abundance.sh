#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36
#SBATCH --mail-user=jgilby@uncc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=68gb                               
#SBATCH --job-name=estAbundance    
#SBATCH --partition=Orion


set -eu
module purge
module load kraken2


start=`date +%s`

SOFTWARE="/scratch/jgilby/utilities/Bracken-2.9"
DB="/projects/gibas_lab/k2_standard_db"

sample_dir="/users/jgilby/viromeProject"
reports=`echo "${sample_dir}/kraken_WW_out/WW_krakenreport_"*`
out_dir="${sample_dir}/bracken_WW_out"
mkdir -p ${out_dir}

for i in ${reports}

do
        echo "looking at $i"

sample="`basename ${i} | cut -d_ -f3`"
        echo "Re-estimating abundances with bracken for ${sample}"

        ${SOFTWARE}/bracken \
                -d ${DB} \
                -i ${i} \
                -o ${out_dir}/${sample}.threshold_bracken \
                -w ${out_dir}/${sample}threshold_bracken_species.report \
                -r 150 \
                -t 10 \
                -l S
done
