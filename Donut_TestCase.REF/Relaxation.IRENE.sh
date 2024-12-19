#!/bin/bash

#MSUB -r Relaxation
#MSUB -e LOG/Relaxation.e%j
#MSUB -o LOG/Relaxation.o%j
#MSUB -n 8
#MSUB -T 7200
#MSUB -A gen6035
#MSUB -q rome
#MSUB -m work,workflash,scratch
#MSUB -E "--parsable"

# here are define option specific to irene
. ~/.bashrc

# change groupe => without this vtu are wrote on ige group => quota exceeded
newgrp gen6035

ulimit -s unlimited

CASE=Relaxation

# LOG links
ln -sf LOG/$CASE.e$SLURM_JOBID elmer.err
ln -sf LOG/$CASE.o$SLURM_JOBID elmer.out

echo $CASE.sif > ELMERSOLVER_STARTINFO

module purge
module load c/intel/20.0.0 c++/intel/20.0.0 fortran/intel/20.0.0 intel/20.0.0 mpi/openmpi/4.0.5
module load flavor/buildcompiler/intel/20 flavor/buildmpi/openmpi/4.0 flavor/hdf5/parallel hdf5/1.8.20
module load netcdf-c/4.6.0 netcdf-fortran/4.4.4
module load cmake/3.22.2
module load nco

module load elmer-130224 #elmer-dev

module load XIOS

make mesh
. ./Relaxation.sh parallel 2 1km
