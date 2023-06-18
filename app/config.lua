local config = require "lapis.config"

-- Maximum file size
local body_size = "1m"

-- Path to your local project files
local lua_path  = "./src/?.lua;./src/?/init.lua;./libs/?.lua;./libs/?/init.lua"
local lua_cpath = ""

config("development", {
	port      = 80,
	body_size = body_size,
	lua_path  = lua_path,
	lua_cpath = lua_cpath,
	server     = "nginx",
	code_cache = "off",
	num_workers = "1",
	name       = "[DEVEL] readit",
	session_name = "dev_app_session",
	secret     = "A not very s3cretive secret.",
	sqlite = {
	  database = "/var/data/dev.sqlite"
	  -- open_falgs = ...
	}  
})

config("production", {
	port       = 80,
	body_size  = body_size,
	lua_path   = lua_path,
	lua_cpath  = lua_cpath,
	code_cache = "on",
	server     = "nginx",
	code_cache = "off",
	num_workers = "1",
	name       = "readit",
	session_name = "prod_app_session",
	secret     = "A string witches also my s3cr3t!",
	track_exceptions = true,
	sqlite = {
	  database = "/var/data/production.sqlite"
	}  
})

config("test", {
	port      = 80,
	body_size = body_size,
	lua_path  = lua_path,
	lua_cpath = lua_cpath,
	server     = "nginx",
	code_cache = "off",
	num_workers = "1",
	name       = "[TEST] readit",
	session_name = "test_app_session",
	secret     = "A different random string",
	sqlite = {
	  database = "/var/data/test.sqlite"
	}
})
