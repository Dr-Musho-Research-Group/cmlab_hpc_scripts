#!/bin/bash

# This is an example of COMSOL job sbatch script.  
#SBATCH -p tdmusho
#SBATCH --job-name=comsol_batch
#SBATCH --output=comsol_batch.%j.output
#SBATCH --error=comsol_batch.%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --time=4:00:00
#SBATCH --mail-user=tmusho+hpcwvu@gmail.com
#SBATCH --mail-type=BEGIN,FAIL,END

#  Start by going to the folder where the data for this job is located.
#  This is where the files used by the job should go.
cd /users/tdmusho/project/comsol_test

# Module purge ensures that no other modules are loaded.
module purge

# Load the COMSOL 5.4 module.
module load mae/comsol/comsol61

# Execute Comsol

comsol batch -usebatchlic -mpibootstrap slurm -nn 1 -nnhost 1 -np 40 -inputfile bipolar_transistor.mph -outputfile bipolar_transistor_output.mph
