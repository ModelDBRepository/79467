//Poisson_train.g
/* choose imax as you want, i.e. number of trains
   choose time length of trains as spike_length,
   note parameters of timetables, e.g. maxtime and mean interval, 
   now 10s and 'isi' s respectively */ 

int imin=0
int imax=328
int loops=1+(imax-imin)/20
int spike_length=10
float isi

randseed

int i, j
include clock

 
pushe /

create neutral /spikes

/* create a set of noise spike trains */

for (isi=1; isi<100; isi=isi*3)

//This outer j loop is because can only have 20 files open at a time

for (j=1; j<loops; j=j+1)
  imin=j*20
  imax=imin+20;
  for (i = {imin}; i < {imax}; i = i + 1)
    create timetable /spikes/tt_{i}
    setfield /spikes/tt_{i} maxtime {spike_length} method 1 act_val 1.0 meth_desc1 {isi} 
    call /spikes/tt_{i} TABFILL
    create event_tofile /spikes/tt_train_{i}
    setfield /spikes/tt_train_{i} threshold 0.5 fname "data/noise-isi"{isi}"-"{i} 
    addmsg /spikes/tt_{i} /spikes/tt_train_{i} INPUT activation
    call /spikes/tt_train_{i} RESET
  end

  check 
  reset

  step {spike_length} -t

echo "elements before deleting:"
le /spikes

  for (i = {imin}; i < {imax}; i = i + 1) 
    call /spikes/tt_train_{i} CLOSE
    delete /spikes/tt_train_{i}
    delete /spikes/tt_{i}
  end

echo "elements after deleting:"
le /spikes

end /* j loop */

end /* isi loop */