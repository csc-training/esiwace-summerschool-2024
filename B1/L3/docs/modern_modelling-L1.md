---
title:  Modern modelling L1
event:  ESiWACE3-WarmWorld Summer School on HPC for Climate and Weather Applications
author: Jarmo Mäkelä
lang:   en
---

# Contents in modern modelling

- Containers and who needs them?
- Overlook on how do we use machine learning in climate sciences
- Explainable AI

# Artificial Intelligence (AI) and Machine Learning (ML)

- Earth system science is difficult as the Earth system is huge, complex and chaotic, and as the resolution of our models is limited

- However, we have a huge amount of observations and Earth system data
    - There are many application areas for machine learning in Earth system sciences

# ML libraries

- Most ML applications are based on Python
    - There is also support for, e.g., Julia, R, C++

- Installing these applications (a large number of small files) directly on "disk", puts a lot of strain on the Lustre file system
    - Don't install conda/pip environments directly on the file systems
    - Don't install pip virtual environments directly on the file systems using the OS python
    - Don't install Python packages directly on the file systems using Easybuild
    - Don't install Python packages directly on the file systems using Spack

# Do use containers

- Some software packages on modern supercomputers are installed as containers
    - May cause some changes to usage
    - Especially important for python applications
    
- Containers provide an easy way to install software
    - A single command installation if a suitable Docker or Apprainer/Singularity container exists

# Containers

- Containers are a way of packaging software and their dependencies (libraries, etc.)

- Popular container engines include Docker, Apptainer (previously called Singularity), Shifter, Podman etc.

- Apptainer is most popular in HPC environments

# Containers and virtual machines (1/2)

![<span style="font-size:40%;"></span>](img/Containers_and_VM.png){.center width=50%}

# Containers and virtual machines (2/2)

- Virtual machines can run a totally different OS than the host computer (e.g. Windows on a Linux host or vice versa)

- Containers share the kernel with the host, but they can have their own libraries
    - They can run, e.g., a different Linux distribution than the host

# Benefits of containers: Ease of installation

- Containers are becoming a popular way of distributing software
    - A single-command installation from existing image
    - More portable since all dependencies are included

- Limited root privileges inside the container if the build system supports it
    - Package managers (yum, apt, etc.) can be utilized even when not available on the target system
    - Some containers need full root access in to build

# Benefits of containers: Environment isolation

- Containers use the host system kernel, but they can have their own bins/libs layer
    - Can be a different Linux distribution than the host
    - Can solve some incompatibilities
    - Less likely to be affected by changes in the host system

# Benefits of containers: Enviroment reproducibility

- Environment can be saved as a whole
    - Useful with, e.g., Python, where updating underlying packages (NumPy, etc.) can lead to differences in the behavior

- Sharing with collaborators is easy (a single file)

# Apptainer in a nutshell

- Containers can be run with user-level rights
    - But: building new containers requires root access or support for `--fakeroot` option

- Minimal performance overhead

- Supports MPI
    - Requires containers tailored to the host system

- Can use host driver stack (Nvidia/CUDA)
    - Add option `--nv`

- Can import and run Docker containers
    - Running Docker directly would require root privileges

# Apptainer on CSC supercomputers

- Apptainer jobs should be run as batch jobs or with `sinteractive`

- No need to load a module

- Users can run their own containers

- Some CSC software installations are provided as containers (e.g. Python environments)
    - See the software pages in Docs CSC for details

# Running Apptainer containers: Basic syntax

- Execute a command in the container
    - `apptainer exec [exec options...] <container> <command>`

- Run the default action (runscript) of the container
    - Defined when the container is built
    - `apptainer run [run options...] <container>`

- Open a shell in the container
    - `apptainer shell [shell options...] <container>`

# File system

- Containers have their own internal file system (FS)
    - The internal FS is always read-only when executed with user-level rights

- To access host directories, they need to be mapped to container directories
     - E.g., to map the host directory `/scratch/project_XX` to the `/data` directory inside the container: `--bind /scratch/project_XX:/data`
     - The target directory inside the container does not need to exist, it is created if necessary
     - More than one directory can be mapped

# Environment variables

- Most environment variables from the host are inherited by the container
    - Can be prevented if necessary by adding the option `--cleanenv`

- Environment variables can be set specifically inside the container by setting on the host `$APPTAINERENV_variablename`.
    - E.g., to set `$TEST` in a container, set `$APPTAINERENV_TEST` on the host

# apptainer_wrapper

- Running containers with `apptainer_wrapper` takes care of the most common `--bind` commands automatically

- You just need to set the `$SING_IMAGE` environment variable to point to the correct Apptainer image file

```
export SING_IMAGE=/path/to/container.sif
apptainer_wrapper exec myprog <options>
```

- Additional options can be set with variable `$SING_FLAGS`, e.g. export `SING_FLAGS=--nv`

# Using Docker containers with Apptainer

- You can build an Apptainer container from a Docker container with normal user rights:
    - `apptainer build <image> docker://<address>:<tag>`

- For example:
    - `apptainer build pytorch_19.10-py3.sif docker://nvcr.io/nvidia/pytorch:19.10-py3`

# Apptainer containers as an installation method

- Apptainer is a good option in cases where the installation is otherwise problematic:
    - Complex installations with many dependencies/files
    - Obsolete dependencies incompatible with the native environment (still needs to be kernel-compatible)
    - Image is a single file

# Methods of building a new Apptainer container

- Building using Tykky
- Building from a definition (aka recipe) file
- Building in “sandbox” mode

