-- require "db.mongo.users";


local ffi = require("ffi")
ffi.cdef[[
    struct timeval {
        long int tv_sec;
        long int tv_usec;
    };
    int gettimeofday(struct timeval *tv, void *tz);
]];
local tm = ffi.new("struct timeval");

function glob_get_utime()   
    ffi.C.gettimeofday(tm,nil);
    local sec =  tonumber(tm.tv_sec);
    local usec =  tonumber(tm.tv_usec);
    return (sec + usec * 10^-6)*1000;
end


function mongo_init( con_str, db_name )
	mongo = require "resty.mongol";
	bson = require "resty.mongol.bson";
	object_id = require "resty.mongol.object_id";
	local _con_str = con_str or config.db.server;
	local _db_name = db_name or config.db.database;
	local _mongo_conn = mongo:new()
        _mongo_conn:set_timeout(30*1000); -- 60 seconds
	local _ok, _err = _mongo_conn:connect( _con_str )
        if not _ok then
                _LOG( _JSON( _ERR( -100, "MONGO DB connect failed: ".._err) ) );
		return ;
        end
	return _mongo_conn:new_db_handle( _db_name ), _mongo_conn;
end;

function mongo_cleanup( conn )
	if( conn ) then
		conn:set_keepalive(0, 100);
	end;
end;

function mongo_getbid( id )
	if( type(id)~= "string" or #id ~= 24) then return nil end;
	return object_id.new(id:gsub("(%x%x)", function(h) return string.char(tonumber(h,16)) end)) ;
end;


function memcached_init(host,port)
	local memcached = require "resty.memcached";
	local memc, err = memcached:new();
	if not memc then
        _LOG( _JSON( _ERR( -100, "Failed To Instantiate Memc.") ) );
        return ;
    end

    memc:set_timeout(60*1000);

    local _host = host or config.memcached.host;
    local _port = port or config.memcached.port;
    local ok, err = memc:connect(_host, _port);
    if not ok then
        _LOG( _JSON( _ERR( -100, "Failed To Connect Memc.") ) );
        return ;
    end

    return memc;
end

function memcached_get(memc,key)
	if (not memc) then
		_LOG( _JSON( _ERR( -100, "memcached is nil") ) );
		return ;
	end
	local res, flags, err = memc:get(key);
    if err then
    	_LOG( _JSON( _ERR( -100, "memcached is nil"..err) ) );
        return ;
    end
    return res;
end

function memcached_put(memc,key,val)
	if (not memc ) then
		return -120,"memcached is nil";
	end
	local ok, err = memc:set(key, val, 600);
    if not ok then

    	-----
		memcached_clear(memc,key);

    	_LOG( _JSON( _ERR( -100, "Failed To Set Memc.") ) );
        return -120,err or 'memcached set failed!';
    end

end

function memcached_clear(memc,key)
	if (not memc ) then
		return -120,"memcached is nil";
	end
	local ok, err = memc:delete(key);
	return 0;
end