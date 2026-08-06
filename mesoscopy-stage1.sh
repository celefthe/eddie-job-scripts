#!/bin/bash

#$ -N mesoscopystage1

#$ -l h_rt=12:30:00
#$ -l h_rss=4G
#$ -pe sharedmem 8

#$ -hold_jid stagein

#$ -m beas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/mesoscopystage1_$JOB_ID.log
#$ -e logs/mesoscopystage1_$JOB_ID.errors

PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

mesoscopy preprocess --interim_dir "$TMPDIR" --crop 20 --bins 4 -o "$OUTBOX" "$1"