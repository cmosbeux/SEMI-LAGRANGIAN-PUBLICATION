all: mesh relax_1km SL_1km

FLAGS="-check all"

mesh:
	ElmerGrid 1 2 MESH.GRD/rectangle_500m.grd -metis 8 0 -autoclean
	ElmerGrid 1 2 MESH.GRD/rectangle_2km.grd 
	ElmerGrid 1 2 MESH.GRD/rectangle_1km.grd -partdual -metiskway 8 -halo
	mv ./MESH.GRD/rectangle_1km rectangle_1km_DG
	ElmerGrid 1 2 MESH.GRD/rectangle_1km.grd  -metis 8 0 -autoclean
	mv ./MESH.GRD/rectangle_1km .
	#sh Relaxation.sh parallel 2 1km
SL_1km:
	sh SL_advection.sh parallel 2 1km
DG_1km:
	sh DG_advection.sh parallel 2 1km



