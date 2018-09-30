--
local _M = { _VERSION = '0.08' }

local mt = { __index = _M }


local function _init_user_data( db, openid, imsi )
        local _result = { result = 0};

        local _rcode, _user = user_getinfo( db, openid );
        if _rcode == 0 then
--[[
                _result.username = _user.username;
		_result.avatar = _user.avatar;
                _result.score = _user.score;
		_result.cancheckin = _user.cancheckin;
		_result.openweibo = _user.openweibo;
		_result.openqq = _user.openqq;
		_result.contact = _user.contact;
		_result.shared = _user.shared;
		_result.lottery_count = _user.lottery_count;
		_result.lastlotteryday = _user.lastlotteryday;
		_result.nickname = _user.selfeditname or _user.nickname or _user.username;
		_result.createtime = _user.createtime;
		_result.charge = _user.charge;
--]]
		_result = _user;
	else 
		if( imsi ) then
			local _imsiinfo = get_imsi_data( db, imsi );
			_result.guest =_imsiinfo;
			if _imsiinfo then
				_result.score = _imsiinfo.score
			end
		end;
		_result.result = _rcode;
        end;
        return _result;
end;

function _M.new( db, openid, imsi )
    local _userdata = _init_user_data( db, openid, imsi );
    return setmetatable({ db = db, openid = openid, imsi = imsi, userinfo = _userdata }, mt)
end

function _M.JSVAR( self )
	local _ret = "";
	if( self.userinfo ) then
		_ret = "var userinfo = "..cjson_safe.encode( self.userinfo )..";\n";
	end;
	return _ret;
end;

function _M.USERNAME( self )
        return self.username or "<a class='loginpanel' href='javascript:do_login();this.blur();'>请登录</a>";
end;

function _M.NICKNAME( self )
	if( self.userinfo.result == 0 ) then
		if( self.userinfo.nickname ) then
			return self.userinfo.nickname;
		else
			if type(self.userinfo.openweibo) == "string" or type(self.userinfo.openweibo) == "table" then
				return "微博用户";
			elseif type(self.userinfo.openqq) == "string" or type(self.userinfo.openweibo) == "table" then
				return "QQ用户";
			else
				return "无名氏";
			end;
		end;
	else
        	return self.userinfo.nickname or "<a class='loginpanel' href='javascript:do_login();this.blur();'>请登录</a>";
	end;
end;

function _M.GUESTNAME( self )
        return self.userinfo.nickname or "游客";
end;

function _M.SCORE( self )
        return tostring(self.userinfo.score or 0);
end;
function _M.SPEND( self )
        return tostring(self.userinfo.spend or 0);
end;

function _M.USERDIV( self )

		local _ret = [[
		<div class="action-bar">
	       	  <div class="name_info">
	            <div class="name_info_01"><img src="/ui/imgs/user_head2.png"/><span>]]..self:NICKNAME()..[[</span></div>
	            <div class="name_info_02"><img src="/ui/imgs/coin.png"/><span>]]..self:SCORE()..[[积分</span></div>
	          </div>
		</div>]];
		if self.web_channel and self.web_channel == "sszzte001" then
			_ret = [[
			<div class="action-bar">
		       	  <div class="name_info">
		            <div class="name_info_01"><img src="/ui/imgs/user_head3.png"/><span>]]..self:NICKNAME()..[[</span></div>
		            <div class="name_info_02"><img src="/ui/imgs/coin.png"/><span>]]..self:SCORE()..[[积分</span></div>
		          </div>
			</div>]];
		end
		return _ret;
end;
function _M.GUESTDIV( self )
        local _ret = [[
        <div class="action-bar">
          <div class="name_info">
            <div class="name_info_01"><img src="/ui/imgs/user_head2.png"/><span>]]..self:GUESTNAME()..[[</span></div>
            <div class="name_info_02"><img src="/ui/imgs/coin.png"/><span>]]..self:SCORE()..[[积分</span></div>
          </div>
        </div>]];
        if self.web_channel and self.web_channel == "sszzte001" then
			_ret = [[
			<div class="action-bar">
		       	  <div class="name_info">
		            <div class="name_info_01"><img src="/ui/imgs/user_head3.png"/><span>]]..self:NICKNAME()..[[</span></div>
		            <div class="name_info_02"><img src="/ui/imgs/coin.png"/><span>]]..self:SCORE()..[[积分</span></div>
		          </div>
			</div>]];
		end
        return _ret;
end;
function _M.go( self, pattern, version, channel )

	self.web_version = version;
	self.web_channel = channel;

	local _replace = function ( s )
		if ( type( self[s] ) == "function" ) then
			return self[s]( self );
		end;
		return "";
	end;
	local _html_out = string.gsub( pattern, "<!%-%-LP_BEGIN%-%-## ([A-Z_]+) ##%-%-LP_END%-%->", _replace );
        return _html_out;
end;

return _M;
