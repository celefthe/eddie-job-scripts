#!/bin/bash

#$ -N histo-maxips
#$ -l h_rt=12:30:00
#$ -l h_rss=8G
#$ -pe sharedmem 8

#$ -hold_jid stagein

#$ -m eas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/histo-maxips.array_$JOB_ID.log
#$ -e logs/histo-maxips.array_$JOB_ID.errors

PATH="$PATH:~/.local/bin/"
OUTBOX="/exports/eddie/scratch/$USER/outbox"

uv run --no-cache ~/generate-maxips.py -o "$OUTBOX" "$1"
