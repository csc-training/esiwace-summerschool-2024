---
title:  The ICOsahedral Nonhydrostatic model (ICON)
event:  ESiWACE3-WarmWorld Summer School on HPC for Climate and Weather Applications
author: Claudia Frauen and Florian Ziemen
lang:   en
---

# What is ICON?

![](img/ICON_logo_black.jpg){.center width=15%}

- ICOsahedral Nonhydrostatic model, a weather and climate model with atmosphere, ocean and land components.
- Its development started more than two decades ago; partners:
  - German Weather Service (DWD)
  - Max Planck Institute for Meterology (MPI-M)
  - Karlsruhe Institute for Technology (KIT)
  - German Climate Computing Center (DKRZ)
  - Swiss Center for Climate Systems Modeling (C2SM)
- Open source: https://www.icon-model.org/

# What are the components of ICON?

![](img/csm_ICON_model_9c699406b8.jpg){.center width=35%}
Credit: Max Planck Institute for Meteorology (https://mpimet.mpg.de/en/research/modeling)

# What is ICON used for?

- ICON is used for applications ranging from numerical weather prediction to CMIP-type climate simulations to km-scale climate simulations

# ICON NWP

- Used for operational **numerical weather prediction** at DWD since 2015
- Other national weather services are using it as well; the latest being Meteo Swiss since June 2024

- DWD setup: 13 km global, 7 km over Europe, 2 km over Germany and surroundings (nested)


# ICON ESM

- Coupled model setup consisting of atmosphere, ocean, land, and optionally ocean biogeochemistry.
- Made for **multi-century climate projections** and experiments.
- With a resolution of 160 km in the atmosphere, and 40 km in the ocean, and without ocean biogeochemistry it achieved a throughput of ~120 simulated years per day on 120 nodes on the DKRZ system Mistral (predecessor of Levante).
- see also [Jungclaus et al., 2022](https://doi.org/10.1029/2021MS002813)

# ICON at km-scales

- ICON is also one of few models worldwide that can be used for coupled simulations at **km-scale allowing to directly simulate storms or ocean eddies** (see also [Hohenegger et al., 2023](https://doi.org/10.5194/gmd-16-779-2023))
- In the NextGEMS project a 30-year simulation was performed with the coupled model with atmosphere (10 km), ocean (5 km) and land components.
- It achieved a throughput of ~1 simulated year per day on 472 nodes of Levante at DKRZ.

# What are we going to do today?

- We want you to run your own ICON experiments!
- 2-year coarse-resolution climate experiments.
- To do that you need to:
    - Get the ICON model code
    - Set up your environment and build the model
    - Create a run script
    - Run the model
    - Check the results 

# Let's get started

- Please pair up in teams of two (or one team of three if needed)
- Log in to levante and go to your work directory
- Get the model code and some helper scripts from Flo's repo:

```
git clone https://gitlab.dkrz.de/flo/icon_with_python.git 
```

- Go to the directory `icon_with_python` and execute the script `build.sh`

# What does the script actually do?

- It downloads and unpacks the ICON model code: `curl https://gitlab.dkrz.de/icon/icon-model/-/archive/release-2024.07-public/icon-model-release-2024.07-public.tar.gz | tar -xzf -`
- (You could also get the code via git: `git clone https://gitlab.dkrz.de/icon/icon-model.git`)

# What does the script actually do?

- Here we want to use a novel method of writing output named hiopy, for which the model is coupled to a python program that writes the data on a so-called healpix grid and which makes the later analysis of the data much easier (more on that in Flo's upcoming lectures)
- For that we need to set up a virtual environment in which we can later install the necessary python package
- Then we can actually build the ICON model

# How to build ICON?

- ICON is already regularly running on a number of HPC sites throughout Europe (like e.g. Levante at DKRZ, LUMI at CSC or JUWELS at JSC)
- Thus it comes with a number of configure scripts to set up the model on these systems (for examples look at your `icon/config` directory)
- For Levante you have a number of scripts based on different compilers and targeting either the CPU or the GPU partition of Levante
- For our example we want to run on the CPU partition and use the intel compiler, since it gives us the best performance

# How to build ICON?


```
../config/dkrz/levante.intel \
    --enable-python-bindings --with-pic \
    --enable-openmp \
    --disable-mpi-checks \
    --enable-comin

```

- There are a lot of options you can use when configuring the model
- For more information try 

```
./configure --help
```

- After the configure step was successful you can use `make` to actually build the model

# What does the script actually do?

- Finally, we need a run script
- ICON comes with a number of run script templates for different types of experiments, which you can find in the directory `icon/run`
- We have prepared a runscript for you. The `build.sh` script links it to `icon/build/run/exp.slo1684.run`

# How is ICON programmed?

- ICON is written mosten in Fortran and consists of more than 1 million lines of code
- It uses a hybrid MPI/OpenMP approach for parallelisation
- The atmosphere and land components have been ported to GPUs using OpenACC directives
- Work is ongoing to port the remaining components

# What hardware can ICON run on?

* ICON is running and regularly tested on a variety of hardware architectures and can run on everything from a laptop to the largest supercomputers in the world
* Standard CPU-systems like Levante (DKRZ)
* GPU-based systems (atmosphere and land) like Levante, Alps (CSCS, Meteo Swiss), LUMI (CSC) and JUWELS Booster (JSC)
* NEC vector (DWD)

# Where does the compute time go?

Assuming same resolutions in atmosphere and ocean:

* 98 % atmosphere and land
* 2 % ocean

Every doubling of the resolution costs a factor of 8 in compute time. 4 times as many grid cells, and half the time step length, as the wind/currents must not pass more than one grid cell per timestep (CFL, the numerics will blow up fast).

nextGEMS R2B8/R2B9: 84% atmosphere, 14% ocean, 2.5% output

# The ICON model grid

![](img/icon_grids.png){.center width=35%}

- Base structure: Icosahedron (20 triangles) covering Earth
- Subdivisions into smaller triangles

- R**X**B**Y** notation 
  - **X** being the number of pieces the edges of the original triangles are divided into 
  - **Y** the number of follow-up Bisections. 

# The ICON MODEL grid

![](img/R2B2.jpg){width=60%}

# The vertical coordinates

![](img/vert-grid.jpg){width=60%}

# The grid cell

![](img/cells.jpg)

# The ICON atmosphere time loop

<div class=column style=width:30%>

![](img/ICON_time_step.jpg)

</div>
<div class=column style=width:65%>
- The dynamical core runs with additional substeps
- Fast physics include cloud microphysics and turbulence
- Slow physics is e.g. radiation
</div>

# What is in an ICON run script?

- SLURM settings:

```
#! /usr/bin/bash
#=============================================================================
#SBATCH --account=bb1153
#SBATCH --job-name=slo1684
#SBATCH --partition=compute
#SBATCH --nodes=4
#SBATCH --output=LOG.slo1684.%j.o
#SBATCH --exclusive
#SBATCH --mem=0
#SBATCH --time=06:00:00
#=============================================================================
```

Please add
```
#SBATCH --qos=esiwace
```

# What is in an ICON run script?

- Parallelisation information:

```
#=============================================================================
# OpenMP environment variables
# ----------------------------
export OMP_NUM_THREADS=1
export ICON_THREADS=1
export OMP_SCHEDULE=dynamic,1
export OMP_DYNAMIC="false"
export OMP_STACKSIZE=200M
#
# MPI variables
# -------------
no_of_nodes=${SLURM_JOB_NUM_NODES:=4}
mpi_procs_pernode=$(( 128 * 1))
((mpi_total_procs=no_of_nodes * mpi_procs_pernode))
```

# What is in an ICON run script?

- srun command:

```
export START="srun -l --kill-on-bad-exit=1 --nodes=${SLURM_JOB_NUM_NODES:-1} //
              --distribution=block:cyclic --hint=nomultithread //
              --ntasks=$((no_of_nodes * mpi_procs_pernode)) //
              --ntasks-per-node=${mpi_procs_pernode} --cpus-per-task=${OMP_NUM_THREADS}"
```

# What is in an ICON run script?

- Grid information:

```
# (1) Basic grid configuration
# -----------------------------

atmos_gridID="0012"             #  icon-nwp grid
atmos_refinement="R02B04"

ocean_gridID="0035"             #  icon-oce ruby-0 grid
ocean_refinement="R02B06"

```

```
atmo_grid_target=iconR2B04_DOM01.nc
atmo_grid_folder="$ICONcoupled/Setup.proto2"
atmo_grid_source=icon_grid_${atmos_gridID}_R02B04_G.nc
add_link_file ${atmo_grid_folder}/${atmo_grid_source} ./$atmo_grid_target

```


# What is in an ICON run script?

- Time step information:

```
# (2) Define the model time stepping
# ----------------------------------
#
dtime=450                        # NWP atmospheric timestep (s)   (same as in atmTimeStep!!)
dt_rad=3600.                     # NWP radiation timestep (s) - must match coupling/ocean time step
oceTimeStep="PT30M"              # ocean time step
atmTimeStep="PT450S"             # atmos time step (for coupler)  (same as dtime!!)
couplingTimeStep="PT30M"         # coupling time step
```

# What is in an ICON run script?

- Paths to initial condition and boundary condition files

``` 
#  ifs2icon for grid 0012
add_link_file $INDIR/ifs2icon_2021010100_0012_R02B04_G.nc ifs2icon_R2B04_DOM01.nc

#-----------------------------------------------------------------------------
#
#   Kinne background aerosols for the year 1850 (irad_aero=12, filename without year)
#    - unified with code of icon-nwp
#
datadir=${atmo_grid_folder}
add_link_file ${datadir}/bc_aeropt_kinne_lw_b16_coa.nc                  ./
add_link_file ${datadir}/bc_aeropt_kinne_sw_b14_coa.nc                  ./
```

# What is in an ICON run script?

- Lots of namelists defining the model configuration

```
&radiation_nml
 irad_o3                 = 79
 irad_aero               = 12
 izenith                 = 4           ! 4: NWP default, 3: no annual cycle
 albedo_type             = 2 ! Modis albedo
 vmr_co2                 = 284.3e-06   !
 vmr_ch4                 = 808.2e-09   ! values for 1850 CE
 vmr_n2o                 = 273.0e-09   ! values for 1850 CE
 vmr_o2                  = 0.20946
 vmr_cfc11               = 0.0
 vmr_cfc12               = 0.0
 direct_albedo           = 4
 direct_albedo_water     = 3
 albedo_whitecap         = 1
 ecrad_llw_cloud_scat    = .true.
 ecRad_data_path         = '${ecRad_data_path}' 
/

```

# What is in an ICON run script?

- The coupling configuration
```
cat > coupling_${EXPNAME}.yaml << EOF
definitions:
  atm2oce: &atm2oce
    src_component: ${modelname_list[0]}
    src_grid: icon_atmos_grid
    tgt_component: ${modelname_list[1]}
    tgt_grid: icon_ocean_grid
    time_reduction: average
[...]
  - <<: [ *oce2atm, *conserv_interp_stack ]
    coupling_period: ${couplingTimeStep}
    field: [sea_surface_temperature]
    scale_summand: 0
[...]
EOF
```

# What is in an ICON run script?

- Output settings
- Restart information
- ...

# Preparing ICON experiments

- Was your build script successfull?
- If so, you should have your icon binary in `icon_with_python/icon/build/bin`
- And a run script `exp.slo1684.run` in `icon_with_python/icon/build/run`
- Let's modify your run scripts, so that we can run a variety of experiments

# Experiments

- Groups 1 and 2: Divide the greenhouse gas (GHG) concentrations by four
- Groups 3 and 4: Multiply the GHG concentrations by four
- Groups 5 and 6: Add 4 K to the ocean temperature reported to the atmosphere.
- Groups 7 and 8: Combine the effects of group 3/4 and 5/6

Groups with even numbers, add 0.01 PPM (parts per million) to the CO2 concentration.

# Examples

- [Clouds at 2.5 km resolution](https://www.youtube.com/watch?v=EzqjAFJYmgY)
- [Currents and sea ice in a high-res run](https://www.youtube.com/watch?v=-l_N8nT9Bnc)
- [Phytoplankton in a high-res run](https://www.youtube.com/watch?v=vZ2P6N57oa0)

# First look at your model data

```python
import intake
cat = intake.open_catalog("/scratch/k/k202134/icon_with_python/outdata/flo0003.yaml")
expid="flo0003"
var='t_2m'
ds=cat[expid].to_dask()
ds[var].mean(dim="cell").plot()
```

# Second look at your model data

```python
import healpy as hp
import matplotlib.pyplot as plt
import numpy as np
good = sum(np.isfinite(ds[var].mean(dim='cell')))
plotdata = cat[expid](zoom=5).to_dask()[var].isel(time=good-1)
hp.mollview(plotdata, flip='geo', nest=True, cmap='inferno')
plt.title(str(plotdata.time.values)[:10])
```

# Want to learn more about ICON?

[The DWD ICON model tutorial](https://www.dwd.de/DE/leistungen/nwv_icon_tutorial/pdf_einzelbaende/icon_tutorial2024.pdf;jsessionid=35224AFB7AD218D564A72308B297A03F.live11042?__blob=publicationFile&v=3)
