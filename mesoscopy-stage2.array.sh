#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) mesoscopy-stage1.array.sh filestoprocess.txt
# Where filestoprocess.txt contains 20 paths to files that need processing

#$ -N mesoscopystage2

#$ -l h_rt=12:30:00
#$ -l h_rss=4G
#$ -pe sharedmem 8

#$ -hold_jid stagein

#$ -m eas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/mesoscopystage2_$JOB_ID.log
#$ -e logs/mesoscopystage2_$JOB_ID.errors

PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

# SGE_TASK_ID will go from 1 to the number of files when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

mesoscopy register landmarks -o "$OUTBOX" -r "${F/_preprocessed.h5/_landmarks.csv}" "$F"

F_out="${F/inbox/outbox}"

mesoscopy process smooth -o "$OUTBOX" "${F_out/.h5/_registered.h5}"
mesoscopy process zscore -o "$OUTBOX" "${F_out/.h5/_registered_smoothed.h5}"

#mesoscopy export deltaf "${F_out/.h5/_registered_smoothed_zscored.h5}"
