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
	session_name = "my_app_session",
	secret     = "A string witches also my s3cr3t!",
	track_exceptions = true,
	sqlite = {
	  database = "site.sqlite"
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
	name       = "[DEVEL] readit",
	session_name = "my_app_session",
	secret     = "A string witches also my s3cr3t!",
	track_exceptions = true,
	sqlite = {
	  database = "production.sqlite"
	  -- open_falgs = ...
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
	name       = "[DEVEL] readit",
	session_name = "my_app_session",
	secret     = "A string witches also my s3cr3t!",
	track_exceptions = true,
	sqlite = {
	  database = "test.sqlite"
	  -- open_falgs = ...
	}
})
