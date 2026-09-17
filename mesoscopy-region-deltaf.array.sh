#!/bin/bash

# To be submitted as a qsub array job
# Requires a text file with filepaths to process, one path per line
# E.g. qsub -t 1-$(cat filestoprocess.txt | wc -l) mesoscopy-region-deltaf.array.sh filestoprocess.txt
# Where filestoprocess.txt contains paths to files that need processing


#$ -N mesoscopydeltaf

#$ -l h_rt=01:30:00
#$ -l h_rss=4G
#$ -pe sharedmem 2

#$ -hold_jid stagein

#$ -m eas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/mesoscopydeltaf_$JOB_ID.log
#$ -e logs/mesoscopydeltaf_$JOB_ID.errors
PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

# SGE_TASK_ID will go from 1 to the number of files when we submit an array job
F=`sed -n ${SGE_TASK_ID}p < $1`

mesoscopy align --behaviour-json "${F/_meso*.h5/.json}" "$F"
mesoscopy process regions -o "$OUTBOX" "$F"

F_out="${F/inbox/outbox}"
mesoscopy process peri-event -o "$OUTBOX" "${F_out/.h5/_regions.csv}" "${F/behaviour-*.h5/behaviour-gonogo_trials.csv}"