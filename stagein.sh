#!/bin/bash
#$ -N stagein 
#$ -q staging

# Hard runtime limit
#$ -l h_rt=12:00:00 

# Make the job resubmit itself if it runs out of time: rsync will start where it left off
#$ -r yes
#$ -notify
trap 'exit 99' sigusr1 sigusr2 sigterm

# Email updates
#$ -m eas
#$ -M Constantinos.Eleftheriou@ed.ac.uk

#$ -o logs/stagein_$JOB_ID.log
#$ -e logs/stagein_$JOB_ID.errors

# Source and destination directories
# Source path on DataStore in the staging environment, user defined
SOURCE="$1"
DESTINATION="/exports/eddie/scratch/$USER/inbox"

mkdir -p ${DESTINATION}

# Perform copy with rsync
# Note: do not use -p (preserve permissions) or -a (implies -p) as this can break file ACLs at the destination
# and force permissive umask when creating and writing for the same reason
# -t preserves dates and time
(umask 000; rsync -rtl ${SOURCE} ${DESTINATION})