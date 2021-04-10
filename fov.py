import sys
import math
import locale
from locale import atof, atoi

def fov_R(sid, sod, su, sv):
    return su/2.0*sod/math.sqrt(sid*sid+(su/2.0)*(su/2.0))

def fov_H(sid, sod, su, sv):
    return fov_R(sid, sod, su, sv)*2.0

def fov_V(sid, sod, su, sv):
    return (sod-fov_R(sid, sod, su, sv))/sid*sv

def main(sid, sod, su, sv, type):
	if type == 0:
		print fov_H(sid, sod, su, sv)
	else:
		print fov_V(sid, sod, su, sv)

main(atof(sys.argv[1]), atof(sys.argv[2]), atof(sys.argv[3]), atof(sys.argv[4]), atoi(sys.argv[5]))