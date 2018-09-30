-- config
---------------------
-- db config --------

config = {}

config.db = {}
config.db.server = "192.168.0.81:18650";
config.db.username = "mongo";
config.db.password = "mongo";
config.db.database = "zy_base";

----mysql
-- config.db.market = {}
-- config.db.market.host = "192.168.0.81";
-- config.db.market.user = "root";
-- config.db.market.passwd = "123456";
-- config.db.market.database = "oz_market";

----memcached
-- config.memcached = {}
-- config.memcached.host = "127.0.0.1";
-- config.memcached.port = 11211;

config.fileupload = {};
config.fileupload.chunksize = 8192;
config.fileupload.tmppath = "/opt";

config.lang = "zh_CN";
