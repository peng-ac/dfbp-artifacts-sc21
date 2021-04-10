function current_file_name(){
	echo ${0##*/}
}
function current_time(){
	echo $(date +"%Y-%m-%d_%H-%M-%S")
}
function add(){ 
	python -c "print ($1+0.0)+($2+0.0)" 
}
function sub(){	
	python -c "print ($1+0.0)-($2+0.0)" 
}
function div(){
	python -c "print ($1+0.0)/($2+0.0)" 
}
function mul(){	
	python -c "print ($1+0.0)*($2+0.0)"
}

function fovH(){
	type=0;	python fov.py $1 $2 $3 $4 $type;
}

function fovV(){
	type=1; python fov.py $1 $2 $3 $4 $type;
}

function Para_tomobank_27_28_29(){
	DIRECTION=-1;
	SID=350.0;   SOD=100.0;    COR=0; 
	SU=$(mul 0.025 2004);    SV=$(mul 0.025 1335);
	SX=$(mul 0.01 1984);   SY=$SX;       SZ=$(mul 0.01 192);
	VOL_ANGLE=3.14159265359;
}

function Para_tomo_00027(){
	Para_tomobank_27_28_29;
	OFFSET_SU=$(mul 0.025 25); OFFSET_SV=$(mul 0.025 0.25);
	NAME=raw_tomo_00027;
}

function Para_tomo_00028(){
	Para_tomobank_27_28_29;
	OFFSET_SU=$(mul 0.025 26); OFFSET_SV=$(mul 0.025 0.25);
	NAME=raw_tomo_00028;
}

function Para_tomo_00029(){
	Para_tomobank_27_28_29;
	SX=$(mul 0.01 1984);   SY=$SX;       SZ=$(mul 0.01 1024);
	OFFSET_SU=$(mul 0.025 27); OFFSET_SV=$(mul 0.025 0.2);
	NAME=raw_tomo_00029;
}

function Para_tomo_00030(){
	DIRECTION=-1;
	SID=350.0;   SOD=250.0;    COR=0; 
	SU=$(mul 0.075 668);   SV=$(mul 0.075 445);
	OFFSET_SU=$(mul 0.075 -10); OFFSET_SV=$(mul 0.025 0.2);
	SX=$(mul 0.058 672);   SY=$SX;    SZ=$(mul 0.058 445);
	VOL_ANGLE=3.14159265359;
	NAME=raw_tomo_00030;
}

function Para_coffeebean(){
	DIRECTION=1;
	SID=$(add 16.009796142578125 135.70033264160156);   SOD=16.009796142578125;    COR=$(div -21.9175 1000); 
	# DUV=$(div 7.305844306945801 1000); DUV=$(mul $DUV $SID); DUV=$(div $DUV SOD); 
	DUV=$(mul $(div 7.305844306945801 1000) $(div $SID $SOD));
	SU=$(mul $DUV 1864)    SV=$(mul $DUV 999);
	OFFSET_SU=0; OFFSET_SV=0;
	SX=$(fovH $SID $SOD $SU $SV); SY=$SX;  SZ=5.64;  #SZ=$(fovV $SID $SOD $SU $SV);
	VOL_ANGLE=0;
	NAME=coffeebean;
}

function Para_coffeebean_6401(){
	Para_coffeebean;
}

function Para_coffeebean_1601(){
	Para_coffeebean;
	SU=$(mul $DUV 1864)    SV=$(mul $DUV 998);
}

function Para_Bumblebee(){
	DIRECTION=1; SID=672.56;  SOD=39.8482437133789;  COR=$(mul 87.3 0.0118); 
	SU=$(mul 0.2 2000);   SV=$(mul 0.2 2000);
	OFFSET_SU=0; OFFSET_SV=0;
	SX=22.7163190228;   SY=$SX;    SZ=23.3994;
	VOL_ANGLE=0;
	NAME=Bumblebee;
}

function Get_param(){
	DU=$(div $SU $NU); DV=$(div $SV $NV);
	#echo DU=$DU, DV=$DV;
	DX=$(div $SX $NX); DY=$(div $SY $NY); DZ=$(div $SZ $NZ); 
	OFFSET_NU=$(div $OFFSET_SU $DU); OFFSET_NV=$(div $OFFSET_SV $DV);

    SRC_PATH="$SRC_DIR/merge_HNW_${NAME}_w${NU}_h${NV}_c${NPROJ}.raw"
	echo "$NPROJ $SID $SOD $COR $DIRECTION $NU $NV $DU $DV $OFFSET_NU $OFFSET_NV $DX $DY $DZ $NX $NY $NZ $VOL_ANGLE $NAME '$SRC_PATH' '$DST_DIR'"
}

##############################################################
function set_parameter_shepp_logan(){
	NX=$1; NY=$2; NZ=$3;
	Para_shepp_logan;
	NPROJ=1024; NU=2048; NV=2048;
}

function set_parameter_coffeebean_1x(){
	NX=$1; NY=$2; NZ=$3;
	Para_coffeebean_6401;
	NPROJ=6401; NU=3728; NV=1998;
}

function set_parameter_coffeebean_2x(){
	NX=$1; NY=$2; NZ=$3;
	Para_coffeebean_6401;
	NPROJ=6401; NU=1864; NV=999;
}

function set_parameter_tomobank_27(){
	NX=$1; NY=$2; NZ=$3;
	Para_tomo_00027;
	NPROJ=1800; NU=2004; NV=1335;
}

function set_parameter_tomobank_28(){
	NX=$1; NY=$2; NZ=$3;
	Para_tomo_00028;
	NPROJ=1800; NU=2004; NV=1335;
}

function set_parameter_tomobank_29(){
	NX=$1; NY=$2; NZ=$3;
	Para_tomo_00029;
	NPROJ=1800; NU=2004; NV=1335;
}

function set_parameter_tomobank_30(){
	NX=$1; NY=$2; NZ=$3;
	Para_tomo_00030;
	NPROJ=720; NU=668; NV=445;
}

function set_parameter_Bumblebee(){
	NX=$1; NY=$2; NZ=$3;
	Para_Bumblebee;
	NPROJ=3142; NU=2000; NV=2000;
}


