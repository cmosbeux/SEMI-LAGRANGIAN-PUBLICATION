#!/bin/bash

# Check if a command-line argument is provided
if [ $# -eq 0 ]; then
    echo "Please provide the execution mode: 'serial' or 'parallel'."
    exit 1
fi

mode=$1
SIMULATION_FILES='EXTRA_SIMUS'
mkdir $SIMULATION_FILES

# Loop from dt = 30 to 360 with steps of 30
for dt in $(seq 90 90 180); do
    # Loop over files matching Adv.R*_Reinit_Nodal.sif
    for file_num in 1 2; do

        # Create the filename
        file="Adv.R${file_num}.Reinit_Nodal"
        # Create a new filename by replacing "*" with dt
        new_file="Adv.R${file_num}.Reinit_Nodal.DT${dt}"

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
            mpirun -np 2 ElmerSolver_mpi "$file"
        else
            echo "Invalid execution mode. Please choose 'serial' or 'parallel'."
            exit 1
        fi

        # Move the output files to a separate folder if desired
        mkdir -p "OUTPUT_FILES"
        file_name=$(basename "$file")
        mv "case.results" "OUTPUT_FILES/${file_name}.results"
        mv "case.vtu" "OUTPUT_FILES/${file_name}.vtu"
    fi
done

