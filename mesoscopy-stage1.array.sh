#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) mesoscopy-stage1.array.sh filestoprocess.txt
# Where filestoprocess.txt contains 20 paths to files that need preprocessing

#$ -N mesoscopystage1

#$ -l h_rt=12:30:00
#$ -l h_rss=4G
#$ -pe sharedmem 8

#$ -hold_jid stagein

#$ -m eas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/mesoscopystage1_$JOB_ID.log
#$ -e logs/mesoscopystage1_$JOB_ID.errors

PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

# SGE_TASK_ID will go from 1 to the number of files when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

mesoscopy preprocess --interim_dir "$TMPDIR" --crop 20 --bins 4 -o "$OUTBOX" "$F"