

function set_output(file_name,comp,variable)
	str	file_name,comp,chan,variable

	create asc_file /output/{file_name}
	setfield /output/{file_name} leave_open 1 filename {file_name}.dat append 0

	addmsg		{comp}		/output/{file_name} SAVE {variable}

	useclock /output/{file_name}	1
end
