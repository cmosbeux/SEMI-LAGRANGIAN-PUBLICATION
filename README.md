# Particle Advector Performance Tests

This repository contains tests to check the performance of the Particle Advector with a 3D-Stokes flow with Elmer/Ice. The tests are designed to be run at different resolutions to evaluate the performance under various conditions.

## About Elmer and Elmer/Ice

[Elmer](https://www.csc.fi/web/elmer) is an open-source multiphysical simulation software developed by CSC - IT Center for Science. Elmer includes physical models of fluid dynamics, structural mechanics, electromagnetics, heat transfer, acoustics, and more. 

[Elmer/Ice](http://elmerice.elmerfem.org/) is a part of the Elmer suite specifically designed for the simulation of ice dynamics. It includes modules for modeling ice flow, thermodynamics, and interactions with the environment.

## Test Cases

> ⚠️ **Note:** More details about the different test cases can be found in the README.md files in the respective directories.


### 1. Discs Test Case

This test is built to check the performance of the Particle Advector with a circular flow in a domain with multiple discs, specifically using the Zalesak's disk problem to evaluate the accuracy and stability of the advection scheme.

### 2. Donut Test Case

This test uses a donut-shape that is advected in a 3D slab domain.  

### 3. SL Advection of damage in the Amundsen Sea Sector

This test is built to check the performance of the Semi-Lagrangian advection scheme with a 3D-Stokes flow. Running the simulation requires an initial state that can be downloaded at XXXX.

<figure>
<center>
<img src="https://github.com/cmosbeux/SEMI-LAGRANGIAN-PUBLICATION/blob/main/Videos/AMU_d1int_dt_test_2000-2050.gif" width=50% height=50%>
<figcaption>Fig. Advected Damage over the Amundsen Sea.</figcaption>
</center>
</figure>