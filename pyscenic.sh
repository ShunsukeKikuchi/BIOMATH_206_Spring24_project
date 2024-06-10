#!/bin/bash
#$ -cwd
# error = Merged with joblog
#$ -o joblog/pyscenic.$JOB_ID
#$ -j y
# Edit the line below to request the appropriate runtime and memory
# (or to add any other resource) as needed:
#$ -l h_rt=20:00:00,h_data=96G
# Add multiple cores/nodes as needed:
#$ -pe shared 1

# Ex. usage: qsub pyscenic.sh RB05

# echo job info on joblog:
echo "Job $JOB_ID started on:   " `hostname -s`
echo "Job $JOB_ID started on:   " `date `
echo " "


# load the job environment:
. /u/local/Modules/default/init/modules.sh
module load anaconda3
# To see which versions of anaconda are available use: module av anaconda
# activate an already existing conda environment (CHANGE THE NAME OF THE ENVIRONMENT):
conda activate /u/project/xyang123/skikuchi/miniconda3/envs/scenic_protocol
# in the following two lines substitute the command with the
# needed command below:
echo "running_pyscenic"

DIR_NAME=/u/home/s/skikuchi/scratch/BIOMATH206
TF=/u/home/s/skikuchi/scratch/BIOMATH206/data/alt1_allTFs_hg38.txt

mkdir -p "${DIR_NAME}/grn/"
# call pyscenic
celltype=$1
celltype_loom=/u/home/s/skikuchi/scratch/BIOMATH206/data/filtered_${celltype}.loom

grn_file="${DIR_NAME}/grn/adj1_${celltype}.csv"

echo ""
echo "pyscenic grn ${celltype_loom} ${TF} -o ${grn_file} --num_workers 16"
pyscenic grn ${celltype_loom} \
        ${TF} \
        -o ${grn_file} --num_workers 16


# echo job info on joblog:
echo "Job $JOB_ID ended on:   " `hostname -s`
echo "Job $JOB_ID ended on:   " `date `
echo " "
### anaconda_python_submit.sh STOP ###