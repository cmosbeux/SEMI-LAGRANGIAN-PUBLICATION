#!/bin/bash

# Check if a command-line argument is provided
if [ $# -eq 0 ]; then
    echo "Please provide the execution mode: 'serial' or 'parallel'."
    echo "and the version number of the test"
    exit 1
fi

mode=$1
version=$2
SIMULATION_FILES=SIMUS.$version
OUTPUT_FILES=OUTPUT.$version

mkdir $SIMULATION_FILES

# Loop from dt = 30 to 360 with steps of 30
for dt in $(seq 30 30 31); do
    # Loop over files matching Adv.R*_Reinit_Nodal.sif
    for file_num in 1 ; do

        # Create the filename
        file="Adv.R${file_num}.Reinit.Nodal"
        # Create a new filename by replacing "*" with dt
        new_file="Adv.R${file_num}.Reinit.Nodal.DT${dt}"

        # Copy the reference file to the new filename
        cp "./REF/$file.sif" "./$SIMULATION_FILES/$new_file.sif"

        # Add lines to the new .sif file
        sed -i "1i\$name=\"$new_file\"" "./$SIMULATION_FILES/$new_file.sif"
        sed -i "2i\$t=$dt" "./$SIMULATION_FILES/$new_file.sif"
    done
done

# Loop through files in the SIMULATION_FILES directory
for file in ./$SIMULATION_FILES/*; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Run the commands based on the chosen mode
        if [ "$mode" = "serial" ]; then
            ElmerSolver "$file"
        elif [ "$mode" = "parallel" ]; then
	    echo "$file" > ELMERSOLVER_STARTINFO
            mpirun -np 2 ElmerSolver_mpi 
        else
            echo "Invalid execution mode. Please choose 'serial' or 'parallel'."
            exit 1
        fi

        # Move the output files to a separate folder if desired
        mkdir -p "$OUTPUT_FILES"
        mv ./square/*vtu $OUTPUT_FILES/.
    fi
done

