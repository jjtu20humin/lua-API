--test7

GV_IFS = GV_IFS or {};
local _module_ = (...):match( "^.*%.(.*)$" );

GV_IFS[_module_] = {
	name = _module_,
	cname = "test",
	desc = "test",
	base_param = {
		--{ name = "sign", pattern = "%w+",length = {32,32}, helper = {"签名","md5hex"}	},
	},

        opt_param = {
                
        },

};

GV_IFS[_module_]['callback'] = function ( db, _REQ, _FILE )
 	local _result = {};

    _result.result = 0 

    return _result;
end;


