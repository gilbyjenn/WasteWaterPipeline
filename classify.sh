#!/bin/bash 

#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=36
#SBATCH --mail-user=jgilby@uncc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=64GB
#SBATCH --job-name=kraken
#SBATCH --partition=Orion

set -eu
module load kraken2
module load blast/2.11.0+
start=`date +%s`

SOFTWARE="/scratch/jgilby/utilities/kraken2"

sample_dir="/users/jgilby/viromeProject"
fastqs_dir="${sample_dir}/trimmed_fastqs/WW_paired"
outdir="${sample_dir}/kraken_WW_out"
mkdir -p ${outdir}

for i in `ls $fastqs_dir/* | grep R1`

do
 echo "Running Kraken2 on " $i

name=`basename $i | cut -d_ -f1`
kraken2 \
    --db /projects/gibas_lab/k2_standard_db \
    --threads 36 \
    --paired \
    --classified-out "${outdir}/classified_WW_reads_${name}#.fastq" \
    --unclassified-out "${outdir}/unclassified_WW_reads_${name}#.fastq" \
    --output "${outdir}/WW_krakenout_${name}.txt" \
    --report "${outdir}/WW_krakenreport_${name}" \
    $i ${i/R1/R2}
done

echo "Done"

end=`date +%s`
echo "took $((end-start)) seconds"
