local config = require("lapis.config")
-- local secret = assert(loadfile("../data/secrets/token.lua"))()

-- Maximum file size (update this in scripts.js too!)
local body_size  = "15m"

-- Maximum comment size (update this in scripts.js too!)
local text_size  = 10000

-- Path to your lua libraries (LuaRocks and OpenResty)
local lua_path  = "./src/?.lua;./src/?/init.lua"

config("development", {
  server     = "nginx",
  code_cache = "off",
  num_workers = "1",
  port       = "8123",
  body_size  = body_size,
	text_size  = text_size,
	lua_path   = lua_path,
  name       = "[DEVEL] readit",
  session_name = "my_app_session",
  secret     = "A string witches also my s3cr3t!",
  track_exceptions = true,
  sqlite = {
    database = "site.sqlite"
    -- open_falgs = ...
  }
})
