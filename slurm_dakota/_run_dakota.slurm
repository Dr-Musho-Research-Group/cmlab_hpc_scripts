#!/bin/csh
#
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tmusho+wvuhpc@gmail.com		
#SBATCH --ntasks=120	
#SBATCH --time=48:00:00	
#SBATCH --mem=64000mb
#SBATCH -p tdmusho

module add tbb/latest 
module add compiler/latest 
module add mpi/latest 
module add lang/python/cpython_3.11.3_gcc122 
module add compiler-rt/latest 
module add mkl/latest 

# *** Print Node Info ***
echo "Node file: ${SLURM_JOB_NODELIST} :"
echo "---------------------"
#cat ${SLURM_JOB_NODELIST}
echo "---------------------"
#set NUM_PROCS=`/bin/awk 'END {print NR}' $SLURM_JOB_NODELIST`
echo "Running on $SLURM_JOB_NUM_NODES nodes."
echo

echo
echo Starting...
echo Run started at:  `date`
echo

#ldd /group/tdmusho/src/dakota/dakota-6.8.0.src/build/src/dakota

cd ${SLURM_SUBMIT_DIR}

# #copy files
cp _run_dakota2dnm /scratch/tdmusho/dakota/

 ##Run the parallel job
echo mpirun /group/tdmusho/src/dakota/dakota-6.8.0.src/build/bin/bin/dakota -i dnm_multidim.in -o dnm_multidim.out > dnm_multidim.s
mpirun /group/tdmusho/src/dakota/dakota-6.8.0.src/build/bin/bin/dakota -i dnm_multidim.in -o dnm_multidim.out > dnm_multidim.stdout

echo
echo Done...
echo Run finished at:  `date`
echo
