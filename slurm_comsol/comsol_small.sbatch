#!/bin/bash
#SBATCH --job-name=comsol_batch
#SBATCH --output=comsol_batch.out
#SBATCH --error=comsol_batch.err
#SBATCH --time=7-04:00:00  # Set the maximum time limit to 7 Days 4 Hours
#SBATCH --partition=tdmusho # Specify the partition where you want to run the job
#SBATCH --nodes=1           # Run on 1 node
#SBATCH --ntasks=20         # Use all 80 cores
#SBATCH --mem=182G          # Use 179GB of RAM
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=youremail+hpc@gmail.com
#SBATCH --nodelist=ttmcm[100-101]  # Only include this node
#SBATCH --cpu-freq=performance
#SBATCH --exclusive
#SBATCH --oversubscribe    # Allow oversubscription of Node - More Threads than Cores

# Directory where input files are located
RESTART_DIR=$(pwd)
cd "$RESTART_DIR"

# Module purge ensures that no other modules are loaded.
module purge

# Load the COMSOL 5.4 module.
module load mae/comsol/comsol61

# Record the start time
START_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "Job $SLURM_JOB_ID started at: $START_TIME"

# Execute Comsol
comsol batch -usebatchlic -nn $SLURM_JOB_NUM_NODES -np $SLURM_NTASKS -inputfile bipolar_transistor.mph -outputfile bipolar_transistor_output.mph

# Record the end time when the task completes
END_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "Job $SLURM_JOB_ID completed at: $END_TIME"
