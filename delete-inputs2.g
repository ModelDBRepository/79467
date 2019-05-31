//delete_inputs2.g
//both AMPA and GABA synaptic inputs to fs cell

function delete_inputs (type, GABAprim, GABAsec, GABAtert, Glusec, Glutert)
str type
int GABAprim, GABAsec, GABAtert
int Glusec, Glutert

int loop1, loop2, j

    delete /spikes/soma_ampa_{type}/spike
    delete /spikes/soma_ampa_{type}
    for (j=1; j<=GABAprim; j=j+1)
        delete /spikes/soma_gaba{j}_{type}/spike
        delete /spikes/soma_gaba{j}_{type}
    end

//deleting synaptic inputs to primary dendrites
for (loop1=1; loop1 < 4 ; loop1 = loop1+1) 
	delete /spikes/primdend{loop1}_ampa_{type}/spike
  	delete /spikes/primdend{loop1}s2_ampa_{type}/spike
	delete /spikes/primdend{loop1}_ampa_{type}
  	delete /spikes/primdend{loop1}s2_ampa_{type}

    for (j=1; j<=GABAprim; j=j+1)
    	delete /spikes/primdend{loop1}_gaba{j}_{type}/spike 
    	delete /spikes/primdend{loop1}s2_gaba{j}_{type}/spike  
    	delete /spikes/primdend{loop1}_gaba{j}_{type} 
    	delete /spikes/primdend{loop1}s2_gaba{j}_{type} 
    end 
end
 
//deleting inputs to secondary  dendrites.
for (loop1 = 1; loop1 < 7; loop1= loop1+1)
    for (j=1; j<=Glusec; j=j+1)
        delete /spikes/secdend{loop1}_ampa{j}_{type}/spike  
        delete /spikes/secdend{loop1}_ampa{j}_{type}  
    end
    for (j=1; j<=GABAsec; j=j+1)
     	delete /spikes/secdend{loop1}_gaba{j}_{type}/spike  
    	delete /spikes/secdend{loop1}_gaba{j}_{type}  
    end

    for (loop2 = 2; loop2 < 5; loop2 = loop2+1)
        for (j=1; j<=Glusec; j=j+1)
            delete /spikes/secdend{loop1}s{loop2}_ampa{j}_{type}/spike  
            delete /spikes/secdend{loop1}s{loop2}_ampa{j}_{type} 
        end
        for (j=1; j<=GABAsec; j=j+1)
        	delete /spikes/secdend{loop1}s{loop2}_gaba{j}_{type}/spike 
            delete /spikes/secdend{loop1}s{loop2}_gaba{j}_{type} 
        end
    end
end

//deleting synaptic inputs to tertiary dendrites
for (loop1 = 1; loop1 < 13; loop1= loop1+1)
    for (j=1; j<=Glutert; j=j+1)
        delete /spikes/tertdend{loop1}_ampa{j}_{type}/spike 
        delete /spikes/tertdend{loop1}_ampa{j}_{type} 
    end

    for (loop2 = 2; loop2 < 9; loop2 = loop2+1)
      for (j=1; j<=Glutert; j=j+1)
    	delete /spikes/tertdend{loop1}s{loop2}_ampa{j}_{type}/spike 
    	delete /spikes/tertdend{loop1}s{loop2}_ampa{j}_{type} 
      end
    end

    if (GABAtert==1)
      delete /spikes/tertdend{loop1}_gaba_{type}/spike 
      delete /spikes/tertdend{loop1}_gaba_{type} 

      for (loop2 = 2; loop2 < 9; loop2 = loop2+1)
      	delete /spikes/tertdend{loop1}s{loop2}_gaba_{type}/spike 
      	delete /spikes/tertdend{loop1}s{loop2}_gaba_{type} 
      end
    end
end

end























