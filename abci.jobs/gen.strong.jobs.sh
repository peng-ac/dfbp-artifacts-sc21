#!/bin/bash
CurrentDir=$(cd $(dirname "$0"); pwd)

para_names='set_parameter_coffeebean_1x set_parameter_coffeebean_2x set_parameter_tomobank_30 set_parameter_tomobank_29 set_parameter_shepp_logan'

function generate(){
	(
        np=$1
        para=$2
		cols=$3
        nodes=$(($np/4))  
		( 
			cd $CurrentDir;
			cp abci.base.sh abci.base.sh.tmp
			sed -i "s/JOB_NODES/$nodes/g" abci.base.sh.tmp
			sed -i "s/JOB_NP/$np/g" abci.base.sh.tmp
			sed -i "s/JOB_COLS/$cols/g" abci.base.sh.tmp
			 
			sed -i "s/JOB_SET_PARAM/$para/g" abci.base.sh.tmp
			mkdir -p strong
			mkdir -p strong/$para
			dst=strong/$para
			fname=$(echo $para | sed "s/_parameter_/./g")
			cmd="mv abci.base.sh.tmp $dst/$fname.$(printf %04d $np).sh"
			echo $cmd; eval $cmd;
		)
	)
}

function gen_strong(){
	(
        para=$1
        cols=$2
		dst=strong/$para
        rm -rf $dst/*.sh
        for ((n=$cols; n<=1024; n*=2)); do
                cmd="generate $n $para $cols"
                echo $cmd; eval $cmd;
        done
	)
}

function strong_jobs(){
		gen_strong set_parameter_coffeebean_1x 16
		gen_strong set_parameter_coffeebean_2x 4
		gen_strong set_parameter_Bumblebee 8
		gen_strong set_parameter_tomobank_29 4
}

strong_jobs


