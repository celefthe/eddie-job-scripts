#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) mesoscopy-stage3.array.sh filestoprocess.txt
# Where filestoprocess.txt contains paths to files that need processing


#$ -N mesoscopy-connectivity

#$ -l h_rt=00:45:00
#$ -l h_rss=1G
#$ -pe sharedmem 8

#$ -hold_jid stagein

#$ -o logs/mesoscopy-connectivity_$JOB_ID.log
#$ -e logs/mesoscopy-connectivity_$JOB_ID.errors
PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

# SGE_TASK_ID will go from 1 to the number of files when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

mesoscopy process connectivity --with-rolling --response-pad 0.05 -o "$OUTBOX" "${F}"