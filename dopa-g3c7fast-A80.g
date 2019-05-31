//dopa-g3c7fast-A80.g
// 
int noiseisi
str noisefile

//files with background and signal synaptic input:
//str signalfile3="data/rect50-isi05-"
str signalfile2="data/rect100-isi05-"
//str signalfile1="data/rect200-isi05-"
// approximate frequency during upstate is 211 Hz.

//simulation time and time steps
float spikeoutdt=1e-3
float vmoutdt=1e-4
float simdt=1e-5 //1e-6 needed for voltage clamp
int maxtime=10
int simreps=10

// indicates whether to include GABA synaptic input
int GABAtert, GABAsec, GABAprim
int Gluprim, Glusec, Glutert
Gluprim=1
Glusec=1
Glutert=1
GABAprim=3
GABAsec=3
GABAtert=0
float corr=0.7

int spikesteps={maxtime/simdt}
int i
str filenam

//read in functions for creating and running simulations
include protodefs-fast
include make_fs_input
include output
include randomize2-2
include delete-inputs2

//create cell
readcell fs_A80-dopa80.p /fs

//create output
create asc_file /output/plot
useclock /output/plot 1
addmsg /fs/soma /output/plot SAVE Vm

//setclocks
setclock 1 {vmoutdt}
setclock 0 {simdt}

check

for (noiseisi=1; noiseisi<100; noiseisi=noiseisi*3)
    noisefile="/home/jeanette/Bg_new/RUNFSOPT/data/noise-isi"@{noiseisi}@"-"
    echo "noiseisi=" {noiseisi} "noisefile=" {noisefile}

/*  for (i=0; i<13; i=i+1)

    randomize2 {signalfile1} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "noiseisi"@{noiseisi}@"-rect200-isi05-A120kv1-g3c7fast-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
    delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}

  end
*/
  for (i=0; i<{simreps}; i=i+1)

    randomize2 {signalfile2} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "noiseisi"@{noiseisi}@"-rect100-isi05-A80-g3c7fast-"@{i}@"dopa80.dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
    delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}

  end

/*  for (i=0; i<{simreps}; i=i+1)

    randomize2 {signalfile3} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "signal" {corr}
    randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

    filenam = "noiseisi"@{noiseisi}@"-rect50-isi05-A120kv1-g3c7fast-"@{i}@".dat"
    setfield /output/plot filename {filenam} initialize 1 append 1 leave_open 1
    reset
    step {spikesteps} 

    delete_inputs noise {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}
    delete_inputs signal {GABAprim} {GABAsec} {GABAtert} {Glusec} {Glutert}

  end
*/
end
