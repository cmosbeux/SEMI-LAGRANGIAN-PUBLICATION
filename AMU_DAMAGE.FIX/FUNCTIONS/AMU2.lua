-- ##################################################
-- CONTAINS Algorithm PARAMETERS (MESH,...) and a few directories

--datadir = "../../DATA"
--outdir = "./vtuoutputs"
--meshdb = "./MESH_1000"


-- ## Min threshold value for Ice thickness (Real)
MINH = 80.0

-- ## levels in the vertical
MLEV = 10

-- ## controlling steady state iterations (e.g. for inversion)
IMIN = 10
IMAX = 500

Tol = 0.01
DPtol = 0.001

-- ## for block preconditioner 
blocktol          = 0.0001  -- linear system convergence tolerance for individual blocks 1-3 in block preconditioner
blocktol_pressure = 0.00001 -- linear system convergence tolerance for individual block 4 in block preconditioner
blockOutInterval  = 20      -- output interval for blocks in block preconditioner
OuterOutInterval  = 10      -- output interval for outer loop in block preconditioner
OuterMaxIter      = 100000   -- Maximum linear iterations for outer loop in block preconditioner
blockMaxIter      = 2000    -- Maximum linear iterations for blocks in block preconditioner
outerLinTol       = 1e-6    -- Linear convergence tolerance for outer loop in block preconditioner

-- ## Mesh refinement parameters

-- ##  the name of the mesh to optimize
MESH_IN="MESH2D"
MESH_OUT="MESH_1000"

-- ## Tolerated errors on U and H
U_err=1.0
H_err=35.0

-- ## mesh size limits in different regions

-- ## absolute minimum mesh size
Mminfine=600.0

-- ## minimum mesh size far from grounding line (may be higher than
-- ## Mminfine to prevent detailed refinement in slow flowing far 
-- ## inland regions).  Set equal to Mminfine if you don't want this.
Mmincoarse=5000.0

-- ## Maximum mesh size far from the grounding line
Mmaxfar=11000.0

-- ## Maximum mesh size close to the grounding line
Mmaxclose=700.0

-- ## maximum mesh size for ice shelves (set this to larger than
-- ## Mmaxfar if you want it to be ignored)
Mmaxshelf=1700.0

-- ## reference velocity used in refinement to set upper limit on
-- ## element size (together with distance from GL).  Sections of
-- ## grounding line with flow speeds higher than this limit will
-- ## have max mesh size Mmaxclose.  Max mesh is allowed to be
-- ## coarser for sections of slower flowing GL.  Set this very
-- ## small (e.g. 0.1) if you want it to be ignored.
refvel = 800.0

-- ## The distance from grounding line at which the upper limit for
-- ## the maximum mesh size is reached
GLdistlim=200000.0

-- ## The distance from the boundary at which the upper limit for
-- ## the maximum mesh size is reached
Bdistlim=70000.0

-- ## For distances beyond distlim, the minimum mesh size may be
-- ## increased towards Mmincoarse on this distance scale
distscale=300000.0


