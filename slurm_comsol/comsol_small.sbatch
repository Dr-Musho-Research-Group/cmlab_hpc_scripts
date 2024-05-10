#!/bin/bash
#SBATCH --job-name=comsol_batch
#SBATCH --output=comsol_batch.out
#SBATCH --error=comsol_batch.err
#SBATCH --time=7-04:00:00  # Set the maximum time limit to 7 Days 4 Hours
#SBATCH --partition=tdmusho # Specify the partition where you want to run the job
#SBATCH --nodes=1           # Run on 1 node
#SBATCH --ntasks-per-node=20         # Use all 20 cores
#SBATCH --mem=182G          # Use 179GB of RAM
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=ap0118@mix.wvu.edu
#SBATCH --nodelist=ttmcm[100-101]  #20 Cores with 20 Tasks
#SBATCH --cpu-freq=performance
#SBATCH --exclusive

#  Input Files and Output Files for COMSOL
INPUT_COMSOL=CG_VF_H_Perovskite_PT.mph
OUTPUT_COMSOL=Cluster_CG_VF_H_Perovskite_output.mph

#  Start by going to the folder where the data for this job is located.
#  This is where the files used by the job should go.
# Directory where restart files are located
RESTART_DIR=/gpfs20/scratch/ap0118/N1/
#cd "$RESTART_DIR"

# Module purge ensures that no other modules are loaded.
module purge

# Load the COMSOL 5.4 module.
#module load mae/comsol/comsol61

# Record the start time
START_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "Job $SLURM_JOB_ID started at: $START_TIME"

# Execute Comsol
/scratch/tdmusho/comsol/comsol61/multiphysics/bin/comsol batch -usebatchlic -mpibootstrap slurm -recoverydir $RESTART_DIR -nn $SLURM_JOB_NUM_NODES -np $SLURM_NTASKS_PER_NODE -inputfile $INPUT_COMSOL -outputfile $OUTPUT_COMSOL -alivetime 15 -recover -mpidebug 10

# Record the end time when the task completes
END_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "Job $SLURM_JOB_ID completed at: $END_TIME"
