local config = require "lapis.config"

-- Path to your local project files
local lua_path  = "./src/?.lua;./src/?/init.lua;./libs/?.lua;./libs/?/init.lua"
local lua_cpath = ""

config("development", {
    port      = 80,
    lua_path  = lua_path,
    lua_cpath = lua_cpath,
    server     = "nginx",
    code_cache = "off",
    num_workers = "1",
    name        = "example",
    session_name = "dev_app_session",
    secret     = "change_me",
    sqlite = {
        database = "/var/data/dev.sqlite"
    }
})
