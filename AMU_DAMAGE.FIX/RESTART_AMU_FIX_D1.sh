#!/bin/bash

# Check if a command-line argument is provided
if [ $# -ne 5 ]; then
    echo "Please provide:"
    echo "   -the value sigma_th"
    echo "   -the time resolution (dt)"
    echo "   -number of internal timesteps (N_internal)"
    echo "   -vtu outputs (dt = 0.01)"
fi


sigma_th=$1
dt=$2
N_internal=$3
dt_output=$4

SIMULATION_FILES=SIMUS
healing_rate=0

#compute the number of timesteps and outputs
total_dt=$(echo "50 / $dt" | bc)
#dt_output=$(echo "1 / $time_resolution" | bc)

echo "------------------------------------------------------"
echo "Damage simulation with:"
echo "     sigma_th     =  0.$sigma_th MPa"
echo "     healing_rate =  0.$healing_rate"
echo "using '$total_dt' timesteps of '$dt' a"
echo "with outputs every: '$dt_output'"
echo "------------------------------------------------------"


mkdir $SIMULATION_FILES
file="AMU_FIX_D1-Glen"
new_file="AMU_FIX_D1int_SIGMA${sigma_th}_HR${healing_rate}_DT${dt}"

# Copy the reference file to the new filename
cp "./REF/RESTART_$file.sif" "./$SIMULATION_FILES/$new_file.sif"

# Add lines to the new .sif file
echo "./$SIMULATION_FILES/$new_file.sif" > ELMERSOLVER_STARTINFO

#change name of simulation in the sif 
sed -i "s/<$file>/$new_file/" "./$SIMULATION_FILES/$new_file.sif"

sed -i "s/<SIGMA_TH>/$sigma_th/" "./$SIMULATION_FILES/$new_file.sif" 
sed -i "s/<HEALING_RATE>/$healing_rate/" "./$SIMULATION_FILES/$new_file.sif" 

# Change timestep size:
sed -i "s/<dt>/$dt/" "./$SIMULATION_FILES/$new_file.sif"
sed -i "s/<dt_pa>/$dt/" "./$SIMULATION_FILES/$new_file.sif"
sed -i "s/<N_internal>/$N_internal/" "./$SIMULATION_FILES/$new_file.sif"
sed -i "s/<dt_output>/$dt_output/" "./$SIMULATION_FILES/$new_file.sif"
sed -i "s/<total_dt>/$total_dt/" "./$SIMULATION_FILES/$new_file.sif"


ccc_mprun -n 32 ElmerSolver_mpi 

