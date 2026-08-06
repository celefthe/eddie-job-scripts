#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) histo-maxips.array.sh dirstoprocess.txt
# Where dirstoprocess.txt contains paths to animal directories that need preprocessing

#$ -N histo-maxips
#$ -l h_rt=12:30:00
#$ -l h_rss=4G
#$ -pe sharedmem 8

#$ -hold_jid stagein

#$ -m eas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/histo-maxips.array_$JOB_ID.log
#$ -e logs/histo-maxips.array_$JOB_ID.errors

PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

# SGE_TASK_ID will go from 1 to the number of directories when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

uv run --no-cache ~/generate-maxips.py -o "$OUTBOX" "$F"