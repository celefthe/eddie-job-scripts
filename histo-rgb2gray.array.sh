#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) histo-rgb2gray.array.sh filestoprocess.txt
# Where filestoprocess.txt contains paths to files that need converting

#$ -N histo-rgb2gray

#$ -l h_rt=12:30:00
#$ -l h_rss=4G
#$ -pe sharedmem 8

#$ -hold_jid stagein

#$ -m beas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/histo-rgb2gray_$JOB_ID.log
#$ -e logs/histo-rgb2gray_$JOB_ID.errors

PATH="$PATH:~/.local/bin/"

# SGE_TASK_ID will go from 1 to the number of files when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

uv run --no-cache ~/rgb2gray.py "$F"
