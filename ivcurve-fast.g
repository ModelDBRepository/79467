//ivcurve-fast.g

int noiseisi=9
str noisefile="/home/jeanette/Bg_new/RUNFSOPT/data/noise-isi"@{noiseisi}@"-"

//simulation time and time steps
float vmoutdt=1e-4
float simdt=1e-5 //1e-6 needed for voltage clamp

// indicates whether to include GABA synaptic input
int GABAtert, GABAsec, GABAprim
int Gluprim, Glusec, Glutert

int i
str filenam

//read in functions for creating and running simulations
include protodefs-fast
include make_fs_input
include output
include randomize2-2
include delete-inputs2

//create cell
readcell fs_newmorphtest.p /fs

//create output
create asc_file /output/plot
useclock /output/plot 1
addmsg /fs/soma /output/plot SAVE Vm

//setclocks
setclock 1 {vmoutdt}
setclock 0 {simdt}

check

Gluprim=1
Glusec=1
Glutert=1
GABAprim=3
GABAsec=3
GABAtert=0
float corr=0.7

function runsim(current, filename)
float current
str filename
    setfield /output/plot filename {filename} initialize 1 append 1 leave_open \
1

    step 5000
    setfield /fs/soma inject {current}
    step 50000
    setfield /fs/soma inject 0.0
    step 5000
end


float current

randomize2 {noisefile} {GABAtert} {GABAsec} {GABAprim} {Gluprim} {Glusec} {Glutert} "noise" {corr}

reset

    filenam = "A100fast-ivplot02.dat"
    current=0.019e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot04.dat"
    current=0.039e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot06.dat"
    current=0.058e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot08.dat"
    current=0.076e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot09.dat"
    current=0.095e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot11.dat"
    current=0.113e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot-02.dat"
    current=-0.022e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot-04.dat"
    current=-0.042e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot-06.dat"
    current=-0.062e-9
    runsim {current} {filenam}

    filenam = "A100fast-ivplot-08.dat"
    current=-0.081e-9
    runsim {current} {filenam}

