#!/bin/bash
#MSUB -n 4              # Number of tasks to use
#MSUB -T 86400           # Elapsed time limit in seconds of the job (default: 7200)
#MSUB -o Job_%I.o        # Standard output. %I is the job id
#MSUB -e Job_%I.e        # Error output. %I is the job id
#MSUB -A gen6035         # Project ID
#MSUB -q rome 
#MSUB -m store,workflash,scratch

newgrp gen6035

# define keywords for directories
#ELMER_SCRATCHDIR=${CCCSCRATCHDIR}
#ELMER_WORKDIR=${GEN6035_ALL_CCCWORKDIR}
#ELMER_HOMEDIR=${CCCHOME}

. ~/.bashrc

#!/bin/bash
ulimit -s unlimited

#Load Modules 
module purge
module load c/intel/20.0.0 c++/intel/20.0.0 fortran/intel/20.0.0 intel/20.0.0 mpi/openmpi/4.0.5
module load flavor/buildcompiler/intel/20 flavor/buildmpi/openmpi/4.0 flavor/hdf5/parallel hdf5/1.8.20
module load netcdf-c/4.6.0 netcdf-fortran/4.4.4
module load cmake/3.22.2
module load nco
module load cdo
module load gnu/8.3.0

#export path for Elmer and load it
export MODULEPATH=/ccc/work/cont003/gen6066/chekkimo/ELMERICE/install_elmerice/Modules:$MODULEPATH
module load elmerfem/elmerfem-762e8f2d-opt

#insert ELMERSTARTINFO

echo 'Starting Simulation'
ccc_mprun ElmerSolver_mpi
