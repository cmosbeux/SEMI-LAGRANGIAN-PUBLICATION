# Particle Advector Donut Test

This test is built to check the performance of the Particle Advector with a 3D-Stokes flow. For a better check, the performance should be tested at 1km resolution.

## Folders and Organization

- **REF**: Contains the `.sif` files for the simulation.
- **MESH.GRD**: Contains the `.grd` files of the 2D domain at 2km, 1km, and 500m resolution.
- **FUNCTIONS**: Contains the functions for the geometry and other utilities.
- **SIMUS.\***: Will be created and contains the simulation files built from the REF files.

## Running the Simulation

The test can be run completely at 2km (serial) or at 1km and 500m (parallel with 8 partitions). To run at 1km, type only: `make`.

### Step-by-Step Instructions

1. **Prepare the Environment**:
   Make sure that you use a late version of Elmer/Ice (i.e. Post September 2024)

2. **Run the Simulation**:

There is 3 levels of: (1) 2 km, (2) 1 km, (3) 500 m. Serial can be used at 2 km, higher resolution better run in parallel (the test is setup with 8 partitions, each on a MPI instance)

For example, to run a SL simulation `TEST1` at 2 km in serial (`serial`), with a 1-km resolution (`1`), 1 internal timestep (`1`), we can type:

   ```sh
     . ./SL_advection.sh serial 2 1 1 TEST1
   ```

3. **Check the Output**:
   - The output files will be moved to the `OUTPUT_FILES` directory (it can be deleted if there is no need for restart)
   - You can find the results in the `VTUs_Outputs` directory (they can be visualised with paraview or with an adapted python script)

### Additional Scripts

- **make_suppl.sh**: Used to create supplementary simulation files with different time steps.
- **makefile**: Contains the commands to build and run the simulations.

### Notes
- Adjust the number of partitions and resolution as needed for your specific test case.
