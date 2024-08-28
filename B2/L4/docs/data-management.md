---
title:  ESM data management
author: Jarmo Mäkelä
event:  ESiWACE3-WarmWorld Summer School 2024
lang:   en
---

# Topics today

- Some general remarks on data management on a HPC system

- Focus on two data formats: NetCDF4 and zarr (and xarray)

- Finalize on an overview of ESMValTool

# What kinds of data do we have?

![<span style="font-size:50%;">https://www.climateurope.eu/wp-content/uploads/2016/03/Global_Observing_system_WMO.jpg</span>](img/Global_Observing_system_WMO.png){.center width=65%}

# The most common ESM data formats

- NetCDF (Network Common Data Form) is the "industry" standard in climate modelling and designed for the array-oriented scientific data
    - Supports large datasets, platform-independent and self-describing

- GRIB (Gridded Binary) is commonly used for meteorological and oceanographic data
    - Supports compression and often used by operational weather centers

- HDF (Hierarchical Data Format) is used in EO and satellite data
    - Under the hood of netCDF

- zarr is the modern alternative for the above
    - Supports chunking, compression and can store metadata

# The ESM data standards

- The Climate Model Output Rewriter (CMOR) is a library used for generating CF-compliant NetCDF files to facilitate model output intercomparison for various Model Intercomparison Projects (MIPs)
    - Not all ESM's output CMOR compliant variables

- Earth System Grid Federation (ESGF) is planning to phase out CMIP3 and CMIP5 data

# NetCDF4 file operations

- Multiplatform and also supported by several python libraries
    - Recommendation to use netCDF4 (with Python)

- A file can be open with three different options:
    - "w" to write a new file,
    - "r" to read only, and
    - "r+" to read and modify contents

```
import numpy as np
from netCDF4 import Dataset
ds = Dataset("test.nc", "w", format="NETCDF4")
```

# A typical netCDF4 file

- Typically a netCDF4 file in climate sciences contains
    - dimensions (time, level, lat, lon)
    - variables (CMOR standard or possibly not)
    - attributes detailing metadata such as units

- Groups and multi-file datasets and parallel reads/writes are also possible

- Before assigning values to variables, it and dimensions need to be created

# NetCDF4 basic syntax

```
time = ds.createDimension("time", "f8", None)
lat = ds.createDimension("lat", "f4", 180)
lon = ds.createDimension("lon", "f4", 360)

lat.units = "degrees_north"
lon.units = "degrees_east"
time.units = "days since 2000-01-01 00:00:00.0"
time.calendar = "gregorian"

lat[:] = np.linspace(-89.5, 89.5, 90)
lon[:] = np.linspace(-179.5, 179.5, 180)

tas = ds.createVariable("tas", "f4", ("time", "lat", "lon",))
tas.units = "K"  
tas.long_name = "Near-Surface Air Temperature"
tas[:, :, :] = 0.0 
```
# NetCDF4 continued

- NetCDF4 for python has a good documentation:
    - https://unidata.github.io/netcdf4-python/

- Supports parallellisation (with e.g. mpi4py)

- Try it out yourselves!

# Zarr and xarray

- 
Zarr and xarray are two Python libraries that work together effectively to handle and analyze large, multidimensional datasets, especially in the context of scientific computing, such as climate data, remote sensing, or geospatial analysis. Here's a look at each tool and how they relate:
1. Zarr: Efficient Storage Format for Large Arrays

    Purpose: Zarr is a format and library for the efficient storage of large, chunked, N-dimensional arrays. It is designed to work with datasets that do not fit into memory, making it ideal for handling very large arrays.

    Key Features:
        Chunking: Divides data into smaller, manageable pieces (chunks), allowing efficient read/write operations on just parts of the data.
        Compression: Each chunk can be compressed, reducing storage requirements.
        Parallel I/O: Supports parallel reads and writes, enabling faster data processing in distributed computing environments.
        Compatibility: Data is stored in a way that is compatible with multiple storage backends, including local disk, cloud storage (e.g., S3, GCS), and distributed file systems.

2. xarray: Data Analysis Library for Labeled, Multidimensional Arrays

    Purpose: xarray is a library that extends the capabilities of NumPy by adding labels to dimensions and coordinates, making it easier to work with multidimensional data. It's widely used in the fields of atmospheric, oceanographic, and climate sciences, where datasets often have labels like time, latitude, and longitude.

    Key Features:
        Labeled Arrays: Uses DataArray and Dataset structures to manage data with labeled dimensions and coordinates.
        Operations on Dimensions: Supports operations like selecting, aggregating, and broadcasting along specific dimensions using labels.
        Integration with Pandas: Works well with Pandas for handling time-series data and other labeled data structures.
        Flexible Data Loading: xarray can handle data from various sources, including netCDF, HDF5, GRIB, and Zarr.

# Relation Between Zarr and xarray

    Data Storage and Access: xarray uses Zarr as one of its backends to efficiently store and access data, especially when dealing with large, out-of-memory datasets. This allows xarray to leverage Zarr’s chunking and parallel I/O capabilities to work efficiently with big data.

    Lazy Loading: When working with Zarr datasets, xarray can lazily load data, meaning it only loads data into memory when explicitly required for computation. This approach minimizes memory usage and speeds up initial data loading.

    Flexible Backends: Through Zarr, xarray can read and write data directly to cloud storage solutions like AWS S3, Google Cloud Storage, and other scalable storage backends, facilitating large-scale data analysis workflows.

    Handling Large Datasets: The combination of xarray’s labeled data structures and Zarr’s efficient storage and I/O handling allows users to perform complex data analysis on datasets that are too large to fit into memory, without needing to preprocess or downsample data excessively.

Common Use Cases

    Climate and Weather Data: Analysis of large datasets from satellite imagery, climate simulations, or observational data often stored in Zarr format, managed and analyzed with xarray.

    Remote Sensing: Handling and processing large-scale Earth observation data, such as data from the Copernicus or Landsat programs.

    Geospatial Analysis: Working with multidimensional spatial-temporal data (e.g., 3D or 4D data cubes).

Example Workflow

    Create Zarr Store: Use Zarr to save a large dataset, splitting the data into chunks and compressing it.
    Open with xarray: Use xarray’s open_zarr() function to access the Zarr dataset lazily.
    Analyze with xarray: Perform labeled operations, like selecting specific time slices, averaging over dimensions, and plotting.

Would you like to see an example code snippet of how to use xarray with Zarr?
