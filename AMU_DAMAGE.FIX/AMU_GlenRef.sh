#!/bin/bash


# Check if a command-line argument is provided
if [ $# -ne 1 ]; then
    echo "Please provide:"
    echo "   -the value sigma_th"
fi


sigma_th=$1
healing_rate=0
SIMULATION_FILES=SIMUS

#compute the number of timesteps and outputs
total_dt=$(echo "50 / $dt" | bc)
#dt_output=$(echo "1 / $time_resolution" | bc)

echo "------------------------------------------------------"
echo "Damage simulation with:"
echo "     sigma_th     =  0.$sigma_th MPa"
echo "     healing_rate =  0.$healing_rate"
echo "------------------------------------------------------"


mkdir $SIMULATION_FILES
file="AMU_FIX_D1-GlenRef"
new_file="AMU_FIX_D1_INIT_SIGMA${sigma_th}_HR${healing_rate}"

# Copy the reference file to the new filename
cp "./REF/$file.sif" "./$SIMULATION_FILES/$new_file.sif"

# Add lines to the new .sif file
echo "./$SIMULATION_FILES/$new_file.sif" > ELMERSOLVER_STARTINFO

#change name of simulation in the sif 
sed -i "s/<$file>/$new_file/" "./$SIMULATION_FILES/$new_file.sif"

sed -i "s/<SIGMA_TH>/$sigma_th/" "./$SIMULATION_FILES/$new_file.sif"
sed -i "s/<HEALING_RATE>/$healing_rate/" "./$SIMULATION_FILES/$new_file.sif"

ccc_mprun -n 32 ElmerSolver_mpi

