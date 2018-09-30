-- glob functions
function md5hex( s )
        local _md5o = md5.new();
        _md5o:update( s);
        return sstr.to_hex( _md5o:final() );
end;

string.split = function(s, p)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end

table.imerge = function(table1, table2)
	for i,v in ipairs(table2) do
		table.insert(table1, v)
	end
	return table1
end

table.merge = function(table1, table2)
	for k,v in pairs(table2) do
		table1[k] = v;
	end
	return table1
end

function _LOG ( ... ) 
	--ngx.log( ngx.NOTICE, ... );
end;

function _DEBUG ( ... )
	ngx.log( ngx.NOTICE, ... );
end;

function _SAY( ... )
	ngx.say( ... );
end;

function _JSON ( ... )
	--
	return cjson.encode( ... );
end;

------------------------------the code below added by bellemere---------------------------
orig_chars = { 
    'F', 'L', '9', 'f', 'I', 'Y', 'O', 'i', 'W', 'U', 
    'y', 'z', '/', 'J', 'r', '5', '7', 'g', '8', 'd', 
    'M', 't', 'R', 'V', 'a', 'G', 'v', 'X', '0', 'l', 
    'm', '6', 'B', 'w', 'j', 'k', 'x', 'e', 'Q', '2', 
    '3', '1', 'q', 'S', 'Z', 'n', 'E', 'A', 'H', 'p', 
    'o', '4', '+', 'P', 'C', 's', 'c', 'u', 'b', 'N', 
    'h', 'K', 'D', 'T' };

crypt_chars = { 
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 
    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 
    'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 
    'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 
    'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 
    'Y', 'Z', '+', '/' };


function table_sub(_src, _start, _num)
    if type(_src) ~= "table"  then
        return {};
    end

    local _total = #_src;
    local _result = {};

    if(_start <= _total) then
        local _end = _start + _num;

        if(_end > _total) then
            _end = _total;
        end

        for i = _start + 1, _end do
            table.insert(_result, _src[i]);
        end
    end

    return _result;
end

function trim(s) 
    return string.gsub(s, "^%s*(.-)%s*$", "%1")
end 


