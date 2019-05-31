//vclamp5-sim.g
// vclamp simulations of fs cell using noise isi=9, 1 synapse distr.
//1 hour per 10 sec -> 8 hours per vh -> 2 corr -> <1 day total

int noiseisi=9
str noisefile="/home/jeanette/Bg_new/RUNFSOPT/data/noise-isi"@{noiseisi}@"-"
str signalfile1="data/rect200-isi05-"
str signalfile2="data/rect200-isi03-"

//simulation time and time steps
float vmoutdt=1e-4
float simdt=1e-6 //1e-6 needed for voltage clamp
float maxtime=10
int simreps=3

// indicates whether to include GABA synaptic input
int GABAtert, GABAsec, GABAprim
int Gluprim, Glusec, Glutert

int spikesteps={maxtime/simdt}
int vmsteps={maxtime/simdt}
int i
str filenam

//read in functions for creating and running simulations
include protodefs
include make_fs_input
include output
include randomize2-2
include delete-inputs2
include vclamp.g

//create cell
readcell fs_newmorphtest.p /fs

make_vclamp /fs/soma
//make_vcgraph /fs/soma

//create output
create asc_file /output/plot
useclock /output/plot 1
addmsg /fs/soma /output/plot SAVE Vm
addmsg /vclamp/rev_sign /output/plot SAVE output

//setclocks
setclock 1 {vmoutdt}
setclock 0 {simdt}
setclock 2 {vmoutdt*10}

check

float vh
Gluprim=0
Glusec=1
Glutert=1
GABAprim=3
GABAsec=3
GABAtert=0
float corr=0.7

/* for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
 */
/*10 sec of upstate (25 upstates) at each vh
  randomize2 {signalfile2} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3glu0isi03c7-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

corr=0.5

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
*/
/* 10 sec of upstate (25 upstates) at each vh 
  randomize2 {signalfile2} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3glu0isi03c5-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

corr=0.2

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
 */
/* 10 sec of upstate (25 upstates) at each vh
  randomize2 {signalfile2} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3glu0isi03c2-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end
*/
corr=0.0
for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0

/* 10 sec of upstate (25 upstates) at each vh */
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3glu0-c0-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

Gluprim=1
Glusec=1
Glutert=1
GABAprim=3
GABAsec=3
GABAtert=0

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0

/* 10 sec of upstate (25 upstates) at each vh */
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3-c0-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

/*corr=0.7
spikesteps={10.0/simdt}

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
 */
/* 30 sec of downstate at each vh
  for (i=0; i<{simreps}; i=i+1)

    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "gaba3-c7-vclamp"@{vh}@"-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1

    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  end
*/
/* 10 sec of upstate (25 upstates) at each vh 
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3-c7-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

corr=0.5

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
*/
/* 30 sec of downstate at each vh 
  for (i=0; i<{simreps}; i=i+1)

    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "gaba3-c5-vclamp"@{vh}@"-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1

    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  end
*/
/* 10 sec of upstate (25 upstates) at each vh 
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3-c5-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end
*/

/*corr=0.2

for (vh=-0.03; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
*/
/* 30 sec of downstate at each vh */
/*  for (i=0; i<{simreps}; i=i+1)

    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "gaba3-c2-vclamp"@{vh}@"-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1

    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  end
*/
/* 10 sec of upstate (25 upstates) at each vh 
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3-c2-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

Gluprim=0
Glusec=1
Glutert=1
GABAprim=3
GABAsec=3
GABAtert=0
corr=0.7

vh=-0.07
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
*/
/* 30 sec of downstate at each vh=-0.07 
  for (i=0; i<{simreps}; i=i+1)

    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "gaba3glu0-c7-vclamp"@{vh}@"-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1

    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  end

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0*/
/* 10 sec of upstate (25 upstates) at each vh 
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3glu0-c7-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

corr=0.5
vh=-0.07
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
*/
/* 30 sec of downstate at each vh 
  for (i=0; i<{simreps}; i=i+1)

    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "gaba3glu0-c5-vclamp"@{vh}@"-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1

    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  end

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0 */
/* 10 sec of upstate (25 upstates) at each vh
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3glu0-c5-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end

corr=0.2

vh=-0.07
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0
*/
/* 30 sec of downstate at each vh 
  for (i=0; i<{simreps}; i=i+1)

    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "gaba3glu0-c2-vclamp"@{vh}@"-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1

    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  end

for (vh=-0.07; vh<-0.01; vh=vh+0.01)
  setfield /vclamp/pulsegen level1 {vh} width1 0.00 delay1 1000.0 baselevel {vh} trig_mode 0 trig_time 0.0*/
/* 10 sec of upstate (25 upstates) at each vh 
  randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
  randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}
  filenam = "gaba3glu0-c2-vclampup"@{vh}@".dat"
  setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
  reset
  step {spikesteps}
 
  delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
  delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
end
*/
