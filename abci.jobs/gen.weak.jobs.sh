#!/bin/bash
CurrentDir=$(cd $(dirname "$0"); pwd)

para_names='set_parameter_coffeebean_1x set_parameter_coffeebean_2x set_parameter_tomobank_30 set_parameter_tomobank_29 set_parameter_shepp_logan'

function generate(){
		(
			np=$1
			para=$2
			cols=$3
			nproj=$4
			nodes=$(($np/4))  
			( 
				cd $CurrentDir;
				cp abci.base.sh abci.base.sh.tmp
				sed -i "s/JOB_NODES/$nodes/g" abci.base.sh.tmp
				sed -i "s/JOB_NP/$np/g" abci.base.sh.tmp
				sed -i "s/JOB_COLS/$cols/g" abci.base.sh.tmp		 
				sed -i "s/JOB_SET_PARAM/$para/g" abci.base.sh.tmp
				sed -i "s/#NPROJ/NPROJ=$nproj/g" abci.base.sh.tmp
			
				mkdir -p weak
				mkdir -p weak/$para
				dst=weak/$para
				fname=$(echo $para | sed "s/_parameter_/./g")
				cmd="mv abci.base.sh.tmp $dst/$fname.$(printf %04d $np).sh"
				echo $cmd; eval $cmd;
				(cd $dst; postsh;)
			)
		)
}

function gen_weak(){
	(
        para=$1
        cols=$2
        rm -rf $para/*.sh
		
		nproj=$(cd $CurrentDir/..; source geometry.sh; eval $para; echo $NPROJ;)
		echo nproj=$nproj

		for ((i=1; i<=$cols; i*=2)); do
		    ((_np=1024/$i)); ((_cols=$cols/$i)); ((_nproj=$nproj/$i));
			cmd="generate $_np $para $_cols $_nproj"; 
			echo i=$i cols=$cols _cols=$_cols cmd=$cmd; eval $cmd;
		done
	)
}

function weak_jobs(){
		gen_weak set_parameter_coffeebean_1x 16
		gen_weak set_parameter_coffeebean_2x 8
		gen_weak set_parameter_Bumblebee 8
		gen_weak set_parameter_tomobank_29 4
}

weak_jobs


