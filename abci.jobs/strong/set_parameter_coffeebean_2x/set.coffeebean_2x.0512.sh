#!/bin/bash

#$-l rt_F=128
# $-l USE_BEEOND=1
#$-cwd
#$-l h_rt=00:50:00

mode=Release
process_name=dfbp

INTEL_HOME=/apps/intel/2020.4/compilers_and_libraries_2020.4.304/linux/
MPI_HOME=$INTEL_HOME/mpi
IPP_HOME=$INTEL_HOME/ipp
CUDA_HOME=/apps/cuda/10.2.89

export LD_LIBRARY_PATH=$MPI_HOME/intel64/lib:$IPP_HOME/lib/intel64:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export PATH=$MPI_HOME/intel64/bin:$PATH

MPIRUN=$MPI_HOME/intel64/bin/mpiexec

source geometry.sh;
#############################
SRC_DIR=$HOME/data/
DST_DIR=$HOME/dump/
LOCAL_DIR=$SGE_LOCALDIR/data/
BATCH_SLICE_COUNT=32
NP=512; COLS=8; 
NPP=4;
GENERATE_DATA=0;

function get_cmd(){
	cmd="$MPIRUN -np $NP -ppn $NPP ./$mode/$process_name $NPP $COLS $LOCAL_DIR $BATCH_SLICE_COUNT $GENERATE_DATA $(Get_param)"
	echo $cmd;
}
# cmd="mkdir $SRC_DIR; cp ~/data/merge_HNW_shepp-logan_w2048_h2048_c4096.raw $SRC_DIR"
# echo cmd=$cmd; eval $cmd;

function Show_param(){
	echo fov=[`fovH $SID $SOD $SU $SV`, `fovV $SID $SOD $SU $SV`]
    echo PATH=$PATH
    echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH
    echo MPIRUN=$MPIRUN
    echo process_name=$process_name
    echo nprocess=$NP npernode=$NPP ROWS=$(( $NP/$COLS )) COLS=$COLS NX=$NX NY=$NY NZ=$NZ NU=$NU NV=$NV NPROJ=$NPROJ
    echo SRC_DIR=$SRC_DIR
    echo DST_DIR=$DST_DIR
    echo LOCAL_DIR=$LOCAL_DIR
    echo NAME=$NAME
    echo cmd= $cmd;
}

Repeat=1
#log=$(ls $(current_file_name))
for ((i=1; i<=$Repeat; i++)); do
	for V in 1024 2048 4096; do
		set_parameter_coffeebean_2x $V $V $V; 
		#NPROJ;
		cmd=$(get_cmd); Show_param; eval $cmd;
		echo ""; echo ==end=================================================================;
	done
done
