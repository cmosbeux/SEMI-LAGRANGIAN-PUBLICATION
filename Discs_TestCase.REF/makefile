all: mesh compile

mesh:
	#ElmerGrid 1 2 square.grd
	#ElmerGrid 1 2 square.grd -metis 2 0 0
	ElmerGrid 1 2 square.grd -partdual -metiskway 2 -halo
compile:
	elmerf90 USFs.F90 -o USFs

serial:
	ElmerSolver 

mpi:
	mpirun -np 2 ElmerSolver_mpi

clean_mesh:
	rm -rf square
