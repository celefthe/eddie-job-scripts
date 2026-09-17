#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) visiomode-generate-regressors.array.sh filestoprocess.txt
# The file filestoprocess.txt should contain paths to raw behaviour json files

#$ -N visiomode-analyse

#$ -l h_rt=00:10:00
#$ -l h_rss=4G

#$ -hold_jid stagein

#$ -o logs/visiomode-analyse_$JOB_ID.log
#$ -e logs/visiomode-analyse_$JOB_ID.errors
PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

# SGE_TASK_ID will go from 1 to the number of files when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

visiomode-analysis session --output-dir "$OUTBOX" "${F}"