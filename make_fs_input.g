

function make_input(chan_path, input_train, input_data)
 
pushe /

 if (!{ exists /spikes})
	create neutral /spikes
 end

create timetable /spikes/{input_train}
setfield /spikes/{input_train} maxtime 10.0 method 4 act_val 1.0 fname {input_data}
call /spikes/{input_train} TABFILL
create spikegen /spikes/{input_train}/spike
setfield /spikes/{input_train}/spike output_amp 1 thresh 0.5 abs_refract 0.0001
addmsg /spikes/{input_train} /spikes/{input_train}/spike INPUT activation
//addmsg {input_train}/tt1  /V_data/voltage PLOTSCALE activation *tt1 *green  0.01  0 
addmsg /spikes/{input_train}/spike {chan_path} SPIKE

pope

end



