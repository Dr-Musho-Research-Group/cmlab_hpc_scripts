#!/bin/bash
#SBATCH --job-name=gfed_scf
#SBATCH --output=gfed_%A_%a.out
#SBATCH --error=gfed_%A_%a.err
#SBATCH --time=04:00:00  # Set the maximum time limit to 4 hours
#SBATCH --partition=standby # Specify the partition where you want to run the job
#SBATCH --ntasks=40
#SBATCH --mem-per-cpu=4G    # Memory limit per CPU
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=tmusho+hpc@gmail.com
#SBATCH --array=1-400%15   # Array of jobs - Launch 10 at a time
#SBATCH --exclude=taicm[001-002]
#SBATCH --cpu-freq=performance
#SBATCH --exclusive

sleep 10 #slow down process

#Will Ensure Modules are Loaded by doing twice
module           load compiler/2021.4.0
module           load mpi/2021.4.0
module           load mkl/2021.4.0
module           load compiler/2021.4.0
module           load mpi/2021.4.0
module           load mkl/2021.4.0

sleep 10 #slow down process

# Record the allocated nodes
ALLOCATED_NODES=$(scontrol show job $SLURM_JOBID | awk '/NodeList=/{print $NF}')
echo "Allocated nodes: $ALLOCATED_NODES"

# Directory where restart files are located
RESTART_DIR=$(pwd)
cd "$RESTART_DIR"

# Calculate the index for this array job
JOB_INDEX=$((SLURM_ARRAY_TASK_ID - 1))

# Create a new folder for this array job
JOB_FOLDER="job_$JOB_INDEX"
mkdir -p "$JOB_FOLDER"
cd "$JOB_FOLDER"

# Record the start time
START_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "Job $JOB_INDEX started at: $START_TIME"

# Define the path to Sobol sequence file
SOBOL_FILE="/users/tdmusho/src/sobol/predefine_12/sobol_sequence_$((SLURM_ARRAY_TASK_MAX - SLURM_ARRAY_TASK_MIN)).txt"

# Check if the Sobol sequence file exists
if [ ! -f "$SOBOL_FILE" ]; then
    # Generate Sobol sequence file
    /users/tdmusho/src/sobol/sobol $((SLURM_ARRAY_TASK_MAX - SLURM_ARRAY_TASK_MIN)) 12 /users/tdmusho/src/sobol/joe-kuo-old.1111 > "$SOBOL_FILE"
fi

# Read Sobol sequence values
SOBOL_VALUES=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$SOBOL_FILE")

# Assign values to each variable
VAR1=$(echo $SOBOL_VALUES | awk '{print 10e-10 + $7 * (20e-10 - 10e-10)}') # X_Plt_Len(m)
VAR2=$(echo $SOBOL_VALUES | awk '{print 10e-10 + $8 * (50e-10 - 10e-10)}') # Y_Plt_Len(m)
VAR3=$(echo $SOBOL_VALUES | awk '{print 10e-10 + $9 * (50e-10 - 10e-10)}') #  X_Mat_Len(m)
VAR4=$(echo $SOBOL_VALUES | awk '{print 10e-10 + $10 * (50e-10 - 10e-10)}') #  Y_Mat_Len(m)
VAR5=$(echo $SOBOL_VALUES | awk '{print 10e-10 + $11 * (50e-10 - 10e-10)}') # X_Tip_Len(m)
VAR6=$(echo $SOBOL_VALUES | awk '{print 10e-10 + $12 * (50e-10 - 10e-10)}') # Y_Tip_Len(m)

VAR7=$(echo $SOBOL_VALUES | awk '{print 0.1 + $1 * (5.0 - 0.1)}') # Workfunction_e (eV)
VAR8=$(echo $SOBOL_VALUES | awk '{print 0.0 + $2 * (1.5 - 0.1)}') # Ef_e (eV)
VAR9=$(echo $SOBOL_VALUES | awk '{print 0.1 + $3 * (5.0 - 0.1)}') # Workfunction_c (eV)
VAR10=$(echo $SOBOL_VALUES | awk '{print 0.0 + $4 * (1.5 - 0.1)}') # Ef_c (eV)

VAR11=$(echo $SOBOL_VALUES | awk '{print 0.5 + $5 * (2.0 - 0.0)}') # Effective Mass_e
VAR12=$(echo $SOBOL_VALUES | awk '{print 0.5 + $6 * (2.0 - 0.0)}') # Effective Mass_c

#'gfed [-d debug_level] X_Plt_Len(m) Y_Plt_Len(m) X_Mat_Len(m) Y_Mat_Len(m) X_Tip_Len(m) &
#                   & Y_Tip_Len(m) Tip_Temp (K) Plate_Temp (K) T_stop (K) V_start(V), V_stop(V), &
#                   & V_steps (#), FE_TE (0,1), Workfunction_e (eV), Effective mass (m/me), Ef_e (eV) &
#                   & Workfunction_c (eV), Ef_c (eV)'

# Define the command to run
COMMAND="/users/tdmusho/src/gfed/double_tip_cpu/bin/gfed_eff_intel d 1"
FULL_COMMAND="$COMMAND $VAR1 $VAR2 $VAR3 $VAR4 $VAR5 $VAR6 300 300 2000 0 1 2 1 $VAR7 $VAR11 $VAR8 $VAR9 $VAR10 $VAR12"


#Sleep to Get Everything Synced
sleep 30

# Execute the command directly
echo $FULL_COMMAND > inputs.log
mpirun $FULL_COMMAND > output.log

# Record the end time when the task completes
END_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "Job $JOB_INDEX completed at: $END_TIME"

cd "$RESTART_DIR" || exit 1



