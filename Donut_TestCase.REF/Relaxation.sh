#!/bin/bash

# Check if a command-line argument is provided
if [ $# -ne 3 ]; then
    echo "Please provide:"
    echo "   -the execution mode: 'serial' or 'parallel'."
    echo "   -the resolution: (1) 2 km, (2) 1 km, (3) 500 m"
    echo "   -the version number of the test (you can also call it e.g. 1km in reference to the resolution)"
    exit 1
fi

mode=$1
resolution=$2
version=$3
SIMULATION_FILES=SIMUS.$version

mkdir $SIMULATION_FILES
file="Relaxation" 
new_file=$file
# Copy the reference file to the new filename
cp "./REF/$file.sif" "./$SIMULATION_FILES/$new_file.sif"

# Add lines to the new .sif file
sed -i "1i\$name=\"$file\"" "./$SIMULATION_FILES/$new_file.sif"

echo "./$SIMULATION_FILES/$new_file.sif" > ELMERSOLVER_STARTINFO

if [ "$resolution" = 1 ]; then 
	sed -i "2i\$resolution=\"2km\"" "./$SIMULATION_FILES/$new_file.sif"
elif [ "$resolution" = 2 ]; then 
	sed -i "2i\$resolution=\"1km\"" "./$SIMULATION_FILES/$new_file.sif"
elif [ "$resolution" = 3 ]; then
	sed -i "2i\$resolution=\"500m\"" "./$SIMULATION_FILES/$new_file.sif"
fi	

# Run the commands based on the chosen mode
if [ "$mode" = "serial" ]; then
	ccc_mprun -n 1 ElmerSolver
elif [ "$mode" = "parallel" ]; then
        #mpirun -np 8 ElmerSolver_mpi 
        ccc_mprun -n 8 ElmerSolver
else
        echo "Invalid execution mode. Please choose 'serial' or 'parallel'."
        exit 1
fi

