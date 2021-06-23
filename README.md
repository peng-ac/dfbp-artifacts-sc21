# Scalable FBP Decomposition for Cone-Beam CT Reconstruction
We use ABCI (https://abci.ai/) HPC to solve image reconstruction by FBP algorithm.
This repository contains the artifact, e.g. job scripts, benchmarks.

## Dependencies
We tested on ABCI, using Nvidia Volta V100 GPUs, with GCC 4.8.5 and NVCC 10.2
The following libraries and tools are requirements:

    cmake = 3.1
    CUDA >= 10.0
    python >= 2.7
    Malab R2018a
    Intel MPI 2020.4.304
    Intel IPP 2020.4.304
    Insight Segmentation and Registration Toolkit (ITK)
    Reconstruction Toolkit (RTK)

## Compiler

    g++ >= 4.8.5
    nvcc >= 10.0
    intel mpicc 2020.4.304


## How to build
    git clone git@github.com:peng-ac/dfbp-artifacts-sc21.git
    cd dfbp; make clean all;

    Note: all modules will be generated in dfbp/Release folder


## Dataset

All geometric parameters used in our evaluation are presented in file *geometry.sh*.

-  Tomobank

       https://tomobank.readthedocs.io/en/latest/#
       we use tomo_00027, tomo_00028, tomo_00029, tomo_00030 in our evaluation

- Coffee bean

      private dataset

- Bumblebee

      private dataset

- shepp-logan phantom

		script                 : phantom3d/phantom3d.m
		projections generation : ./generate-projections.sh

## Jobs running on ABCI
all jobs used are stored in folder *abci.jobs*

- Strong scaling evaluation jobs

      set.Bumblebee.0008.sh
      set.Bumblebee.0016.sh
      set.Bumblebee.0032.sh
      set.Bumblebee.0064.sh
      set.Bumblebee.0128.sh
      set.Bumblebee.0256.sh
      set.Bumblebee.0512.sh
      set.Bumblebee.1024.sh
      set.coffeebean_1x.0016.sh
      set.coffeebean_1x.0032.sh
      set.coffeebean_1x.0064.sh
      set.coffeebean_1x.0128.sh
      set.coffeebean_1x.0256.sh
      set.coffeebean_1x.0512.sh
      set.coffeebean_1x.1024.sh
      set.coffeebean_1x.2048.sh
      set.coffeebean_2x.0004.sh
      set.coffeebean_2x.0008.sh
      set.coffeebean_2x.0016.sh
      set.coffeebean_2x.0032.sh
      set.coffeebean_2x.0064.sh
      set.coffeebean_2x.0128.sh
      set.coffeebean_2x.0256.sh
      set.coffeebean_2x.0512.sh
      set.coffeebean_2x.1024.sh
      set.tomobank_29.0004.sh
      set.tomobank_29.0008.sh
      set.tomobank_29.0016.sh
      set.tomobank_29.0032.sh
      set.tomobank_29.0064.sh
      set.tomobank_29.0128.sh
      set.tomobank_29.0256.sh
      set.tomobank_29.0512.sh
      set.tomobank_29.1024.sh

- Weak scaling evaluation jobs

      set.Bumblebee.0128.sh
      set.Bumblebee.0256.sh
      set.Bumblebee.0512.sh
      set.Bumblebee.1024.sh
      set.coffeebean_1x.0064.sh
      set.coffeebean_1x.0128.sh
      set.coffeebean_1x.0256.sh
      set.coffeebean_1x.0512.sh
      set.coffeebean_1x.1024.sh
      set.coffeebean_2x.0128.sh
      set.coffeebean_2x.0256.sh
      set.coffeebean_2x.0512.sh
      set.coffeebean_2x.1024.sh
      set.tomobank_29.0256.sh
      set.tomobank_29.0512.sh
      set.tomobank_29.1024.sh

## How to run
    the command we use on ABCI will be like qsub -g GROUP_ID job_name

    example:  qsub -g GROUP_ID set.Bumblebee.0008.sh




- Run benchmarks

The related benchmarks can be found in follows:

https://www.openrtk.org/

https://github.com/LLNL/ior

https://docs.nvidia.com/cuda/cuda-samples/index.html




## Help/Support:
For more information or questions, contact the authors at peng.chen.ac#gmail.com (replace # by @, please)
