#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) mesoscopy-regression.array.sh filestoprocess.txt
# Where filestoprocess.txt contains paths to files that need processing
# Each file is a recording, assume a regressor NPZ file exists in the same directory. 
# 

#$ -N mesoscopyregression

#$ -l h_rt=12:30:00
#$ -l h_rss=4G
#$ -pe sharedmem 4

#$ -hold_jid stagein

#$ -m eas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/mesoscopyregression_$JOB_ID.log
#$ -e logs/mesoscopyregression_$JOB_ID.errors
PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

# SGE_TASK_ID will go from 1 to the number of files when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

mesoscopy process regression -o "$OUTBOX" "$F" "${F/_behaviour-*.h5/_behaviour-gonogo_regressors.npz}"