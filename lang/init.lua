require ( "lang."..config.lang );

function _ERR( err_code, additional_msg)
	local _tmp_amsg = additional_msg or "";
	local _tmp_emsg = "";
	if err_code == -4003 then
		err_code = 2;
	end;

	if( GV_ERRORS[ err_code ] ) then
		_tmp_emsg = GV_ERRORS[ err_code ].._tmp_amsg;
	else
		_tmp_emsg = "ERR"..tostring(err_code)..". ".._tmp_amsg;
	end;
	
	return { result = err_code, desc = _tmp_emsg };
end;

