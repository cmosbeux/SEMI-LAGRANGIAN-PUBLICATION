#!/bin/bash

# Check if a command-line argument is provided
if [ $# -ne 5 ]; then
    echo "Please provide:"
    echo "   -the execution mode: 'serial' or 'parallel'."
    echo "   -the resolution: (1) 2 km, (2) 1 km, (3) 500 m"
    echo "   -the time resolution"
    echo "   -the number of internal timesteps"
    echo "   -the version number of the test"
    exit 1
fi

mode=$1
resolution=$2
time_resolution=$3
internal_timesteps=$4
version=$5
SIMULATION_FILES=SIMUS.$version

#compute the number of timesteps and outputs
timestep_intervals=$(echo "50 / $time_resolution" | bc)
output_interval=$(echo "1 / $time_resolution" | bc)

echo "------------------------------------------------------"
echo "using '$timestep_intervals' timesteps of '$time_resolution' dt"
echo "with outputs every: '$output_interval'"
echo "------------------------------------------------------"


mkdir $SIMULATION_FILES
file="Test_PA"
new_file="Test_PA_R$2_DT$3_N$4_$1" 

# Copy the reference file to the new filename
cp "./REF/$file.sif" "./$SIMULATION_FILES/$new_file.sif"

# Add lines to the new .sif file
sed -i "1i\$name=\"$file\"" "./$SIMULATION_FILES/$new_file.sif"
sed -i "2i\$restart=\"Relaxation\"" "./$SIMULATION_FILES/$new_file.sif"

echo "./$SIMULATION_FILES/$new_file.sif" > ELMERSOLVER_STARTINFO

if [ "$resolution" = 1 ]; then 
	sed -i "3i\$resolution=\"2km\"" "./$SIMULATION_FILES/$new_file.sif"
elif [ "$resolution" = 2 ]; then 
	sed -i "3i\$resolution=\"1km\"" "./$SIMULATION_FILES/$new_file.sif"
elif [ "$resolution" = 3 ]; then
	sed -i "3i\$resolution=\"500m\"" "./$SIMULATION_FILES/$new_file.sif"
fi	

#change name of simulation in the sif 
sed -i "s/\$name=\"$file\"/\$name=\"$new_file\"/" "./$SIMULATION_FILES/$new_file.sif"

# Change number of internal timesteps:
sed -i "s/\$internal_timesteps = 1/\$internal_timesteps = $internal_timesteps/" "./$SIMULATION_FILES/$new_file.sif"

#change timestep size
sed -i "s/\$timestep_size = 1/\$timestep_size = $time_resolution/" "./$SIMULATION_FILES/$new_file.sif"

#change total number of timestep accordingly
sed -i "s/\$timestep_intervals = 100/\$timestep_intervals = $timestep_intervals/" "./$SIMULATION_FILES/$new_file.sif"

#change output interval accordingly
sed -i "s/\$output_interval = 1/\$output_interval = $output_interval/" "./$SIMULATION_FILES/$new_file.sif"


# Run the commands based on the chosen mode
if [ "$mode" = "serial" ]; then
	ElmerSolver
elif [ "$mode" = "parallel" ]; then
        ccc_mprun -n 8 ElmerSolver_mpi 
else
        echo "Invalid execution mode. Please choose 'serial' or 'parallel'."
        exit 1
fi

