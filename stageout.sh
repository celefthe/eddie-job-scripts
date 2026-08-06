#!/bin/bash
#$ -N stageout
#$ -q staging

# Hard runtime limit
#$ -l h_rt=12:00:00 

#$ -o logs/stageout$JOB_ID.log
#$ -e logs/stageout_$JOB_ID.errors

# Make the job resubmit itself if it runs out of time: rsync will start where it left off
#$ -r yes
#$ -notify
trap 'exit 99' sigusr1 sigusr2 sigterm

# Source and destination directories
#
# Source path on Eddie. It should be on the fast Eddie HPC filesystem, starting with one of:
# /exports/csce/eddie, /exports/chss/eddie, /exports/cmvm/eddie, /exports/igmm/eddie or /exports/eddie/scratch, 
#
SOURCE="/exports/eddie/scratch/$USER/outbox"
DESTINATION="/exports/cmvm/datastore/sbms/groups/INCR-DuguidLab/rett-sensorimotor-learning/inbox/" 

mkdir -p ${DESTINATION}

# Perform copy with rsync
# Note: do not use -p (preserve permissions) or -a (implies -p) as this can break file ACLs at the destination
# and force permissive umask when creating and writing for the same reason
# -t preserves dates and time
rsync -rtl ${SOURCE} ${DESTINATION}
