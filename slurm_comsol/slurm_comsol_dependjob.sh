#This script is written to hold a job until another job is complete.
#
#

#!/bin/bash

# Get list of all your slurm jobs
job_list=$(squeue -u ap0118 -o "%.18i %.9P %.100j %.8u %.8T %.10M %.9l %.6D %R" | awk '{if(NR>1) print $1}')

# Check if there are any jobs
if [ -z "$job_list" ]; then
    echo "No active jobs found."
    exit 1
fi

# Prompt to select a job
echo "Select a job to set dependency for the new job:"
select job_id in $job_list; do
    if [ -n "$job_id" ]; then
        break
    else
        echo "Invalid selection, please try again."
    fi
done

# Prompt for the new job script
read -p "Enter the path to the sbatch script you want to submit: " sbatch_script

# Submit the new job with dependency
sbatch -d afterany:$job_id $sbatch_script

echo "New job submitted with dependency on job $job_id."

