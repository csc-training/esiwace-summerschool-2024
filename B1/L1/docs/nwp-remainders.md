---
title:  Classical Modelling of Weather and Climate (2)
lang:   en
author: Victoria Sinclair, University of Helsinki
---




# Ensemble Forecasting (1)
<div class="column" style="width:60%">
- The atmospheric is inherently chaotic
- Small errors will grow and become larger as forecast length increases
- All forecasts / NWP models have two types of errors:
- initial state errors as we do not know the initial state of the atmosphere perfectly
- model formulation errors - we cannot resolve all processes perfectly
</div>
<div class="column" style="width:35%">
![](img/ensemble1.png)
<div style=font-size:0.4em>  
https://www.e-education.psu.edu/meteo810/content/l4_p6.html </div>
</div>

# Ensemble Forecasting (2)
- Ensemble forecasting aims to obtain estimates of predictability and forecast skill
- Ensemble forecasts involve producing a set of different forecasts given an initial weather situation.
- Two approaches to create the different forecasts:
- Perturb the initial conditions to account for initial condition uncertainty
- Apply small stochastic perturbations to the model physics to account for uncertainties in the model formulation.

# Ensemble Forecasting (3)
- Used operationally by most national weather forecast agencies for weather, sub seasonal and seasonal forecasting
- Also used in the climate modelling community
- Less common in climate modelling due to the large computational expense but can be very useful
	- Multi-model ensembles are more commonly used
	
	
# Example Ensemble Weather Forecast
<div class="column" style="width:40%">
![](img/example_meteogram.png){.center}
</div>

<div class="column" style="width:50%">
<div style=font-size:0.8em>
- "Meteogram" from ECMWF for Helsinki
- Forecast from last Friday, covers the time period until Monday 2nd
- boxes show the spread in the ensemble (10 - 90th percentiles)
- lines show the max and min values
- from www.ecmwf.int </div>
</div>

# Example Ensemble Weather Forecast
<div class="column" style="width:40%">
![](img/plumes.png){.center}
</div>

<div class="column" style="width:50%">
- "Plumes diagram" for same location / dates as last slide
- Spread (uncertainity) increases with forecast length
- from www.ecmwf.int
</div>

# Example Ensemble Weather Forecast
![](img/ensemble_probs_T25C.png){.center width=65%}
Can compute probabilities of certain weather events, e.g. temperature exceeding 25C  (from www.ecmwf.int)



# Reanalysis data
<div class="column" style="width:60%">
- Combination of model and observations
  - Data assimilation
- Can be considered our best guess of the state of the atmosphere but not complete “truth”
- Gridded datasets – 4 dimensional (x,y,z,t)
- Contains hundreds of variables
	- temperature, winds, cloud properties, rain, snow, soil temperature etc
</div>
<div class="column" style="width:35%">
![](img/reanalysis.jpg)
<div style=font-size:0.4em>https://www.ecmwf.int/en/about/media-centre/science-blog/2017/era5-
new-reanalysis-weather-and-climate-data   </div>
</div>

# ERA5 Reanalysis
- One of the most commonly used reanalysis
- Developed by the European Centre for Medium Range Forecasts (ECWMF)
- Available at 1 hourly temporal resolution from the 1st January 1940 – present
- 0.25 degree horizontal grid spacing
- 137 model levels, data also on 37 pressure levels
- Huge data set ~5 petabytes
- Openly available: https://cds.climate.copernicus.eu
- Ideal training dataset for ML models


# Part 4: What are Earth System Models (ESMs)

# Earth System Models
- How do these differ from a numerical weather prediction model?

# Earth System Models
- Includes all aspects of the Earth system - physical, chemical and biological processes – not just the atmosphere
- Includes the global carbon cycle, dynamic vegetation, atmospheric chemistry, ocean bio-geo-chemistry and ice sheets
- Many different sub-models that are coupled together - massive amount of code!
- These models participate in CMIP (Coupled Model Intercomparison Project)
- Atmospheric part is the same dynamics + physics (and sometimes even the same code) as NWP models


# Earth System Models - feedbacks
- Allow for complex feedbacks to be modelled
- Two examples:
	- increasing CO_2 emissions -> increased temperatures -> sea ice loss -> increased albedo -> increased temperatures
	- increased temperatures -> more biogenic emissions from vegetation -> potentially more aerosol -> more CCN -> diffreent cloud properties
	
- many more feedbacks exist!



# EC-Earth
<div class="column">
- EC-Earth is one ESM, developed by a consortium in Europe (grey shaded countries)
- <https://gmd.copernicus.org/articles/15/2973/2022/>
</div>

<div class="column">
![](img/ECEarth.png)
</div>

# EC-Earth 
<div class="column" style="width:60%">
- Contains many different models of different parts of the Earth System
- These need to be coupled together – can be a computational bottleneck
</div>

<div class="column" style="width:35%">
![](img/gmd_ecearth_components.png)
</div>

# EC-Earth 
<div class="column" style="width:60%">
- Many variables need to be passed back and forward between the different components of an ESM.
- Red arrows with numbers indicate the time frequency that variables are passed
  - range from 45 minutes to 1 year depending on the processes
- Traditionally chemistry was a separate model, now moving to combine it with the atmospheric model
</div>
<div class="column" style="width:35%">
![](img/gmd_ecearth_components.png)
</div>

# EC-Earth 
<div class="column">
Variables that are passed from the atmosphere model (IFS) to the Chemistry Transport model (TM5) in EC-Earth3 and vice-versa.
</div>
<div class="column">
![](img/ec_earth_table.png)
</div>

# Part 5: Remaining challenges

# Remaining challenges
- What do you think the biggest challenges are in:
	- Numerical Weather Prediction?
   -  Earth System modelling? 
 
- Discuss with the people next to you

# Remaining challenges
- Many extreme events occur on small scales are our models do not resolve them well
- To have higher resolution models, requires more computing power - or more computationally efficient models
- Including more and more processes increases computational cost
- Almost all NWP and ESM models are written in Fortran

# A few words about my own research
 - If you are interested, have similar interests please come and talk to me

#
![](img/my_research1.png){width=80%}

#
![](img/my_research2.png){width=80%}

 

# Thank you

Any questions?

victoria.sinclair@helsinki.fi

# Useful textbooks
- "Atmospheric modeling, data assimilation and predictability" by Eugenia Kalnay (2003; Cambridge University Press).
- "Numerical weather and climate prediction" by Thomas Tomkins Warner (2011; Cambridge University Press).
- "Operational weather forecasting" by Peter Innes and Steve Dorling (2013; Wiley-Blackwell).
- "Basic Numerical Methods in Meteorology and Oceanography" by Kristofer Döös, Peter Lundberg, Aitor Aldama Campino  https://doi.org/10.16993/bbs 
<!--CHARNEY, J.G., FJÖRTOFT, R. and Von NEUMANN, J. (1950), Numerical Integration of the Barotropic Vorticity Equation. Tellus, 2: 237-254. https://doi.org/10.1111/j.2153-3490.1950.tb00336.x

# Quick cut-n-paste snippets for easy reference

Two columns:

<div class="column">
- Hello
</div>
<div class="column">
<img src="/home/vsinclai/python/CMIP6_analysis/box_whisker_mean_T_HPC_proposal_v3.png" width="600">
</div>

<!--Image: ![](img/)

Code block:

```
```

New section:

# New section {.section}

-->
