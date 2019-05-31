// genesis

function make_vclamp(path)
str	path
int	dur, hold, delay
float	clampval

    create neutral /vclamp
	create pulsegen /vclamp/pulsegen

	create 	diffamp /vclamp/Vclamp
	setfield    	^	saturation	999.0 \
			gain		1.0

	create 	RC 	/vclamp/lowpass
	setfield    	^ 	R		1 \  
			C		0.00001

	create 	PID 	/vclamp/PID
	/* parameters for 0.001 time step */
/*	setfield ^	gain		0.003 \ 
			tau_i	        3e-7 \  
			tau_d		0.01 \      	
			saturation	400.00	
*/	/* parameters for 0.005 time step */
/*	setfield ^	gain 		0.35 \
			tau_i		4e-5 \
			tau_d		0.2 \
			saturation	400.00
*//*parameters for fs cell*/
setfield ^ gain 1e-5 tau_i 0.00001 tau_d 0.0000001 saturation 999.0

create diffamp /vclamp/rev_sign
setfield ^ saturation 999.0 gain -1.0
addmsg /vclamp/PID /vclamp/rev_sign PLUS output

	addmsg /vclamp/pulsegen  /vclamp/lowpass	INJECT  output
	addmsg /vclamp/lowpass  	/vclamp/Vclamp 	PLUS	state
	addmsg /vclamp/Vclamp    /vclamp/PID	CMD	output
	addmsg {path}	    	/vclamp/PID	SNS	Vm
	addmsg /vclamp/PID 	{path}		INJECT  output
end

function make_vcgraph(path)
str path

  create xform /vcplot [10,10,600,400]

  create xgraph /vcplot/pulsegen -title "Pulse generator" -hgeom 50% -wgeom 50%
  setfield ^ ymin -0.080 ymax -0.020 xmax 0.1 XUnits msec YUnits millivolts
  create xgraph /vcplot/inject -title "injected current" -hgeom 50% -wgeom 50%
  setfield ^ ymin -1e-10 ymax 1e-10 xmax 0.1 XUnits msec YUnits nanoAmps
  create xgraph /vcplot/vclamp -title "command voltage" -xgeom 300 -ygeom 0 -hgeom 50% -wgeom 50%
  setfield ^ ymin -0.080 ymax -0.02 xmax 0.1 XUnits msec YUnits millivolts
  create xgraph /vcplot/vm -title "membrane potential" -xgeom 300 -hgeom 50% -wgeom 50%
  setfield ^ XUnits mSec YUnits mV xmax 0.1 ymin -0.10 ymax 0.020
  xshow /vcplot

  // send messages from vlcamp devices to their graphs
  addmsg /vclamp/pulsegen /vcplot/pulsegen PLOT output *pulsegen *red
  addmsg /vclamp/PID /vcplot/inject PLOT output *PID *blue
  addmsg /vclamp/Vclamp /vcplot/vclamp	PLOT output *Vclamp *black
  addmsg {path} /vcplot/vm PLOT Vm *voltage *black

end

