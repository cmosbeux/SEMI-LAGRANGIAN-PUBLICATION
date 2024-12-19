#!/bin/bash

#MSUB -r SL_advection
#MSUB -e LOG/SL_advection.e%j
#MSUB -o LOG/SL_advection.o%j
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

CASE=SL_advection

# LOG links
ln -sf LOG/$CASE.e$SLURM_JOBID elmer.err
ln -sf LOG/$CASE.o$SLURM_JOBID elmer.out

#echo $CASE.sif > ELMERSOLVER_STARTINFO

module purge
module load c/intel/20.0.0 c++/intel/20.0.0 fortran/intel/20.0.0 intel/20.0.0 mpi/openmpi/4.0.5
module load flavor/buildcompiler/intel/20 flavor/buildmpi/openmpi/4.0 flavor/hdf5/parallel hdf5/1.8.20
module load netcdf-c/4.6.0 netcdf-fortran/4.4.4
module load cmake/3.22.2
module load nco

module load elmer-130224 #elmer-dev
module load XIOS

. ./SL_advection.sh serial 2 1 1 TEST1
. ./SL_advection.sh parallel 2 1 5 TEST1
#. ./SL_advection.sh parallel 2 0.5 5 TEST1
#. ./SL_advection.sh parallel 2 0.25 5 TEST1
#. ./SL_advection.sh parallel 2 0.1 5 TEST1
#. ./SL_advection.sh parallel 2 0.01 5 TEST1
