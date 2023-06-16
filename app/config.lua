local config = require("lapis.config")

config("development", {
  server = "nginx",
  code_cache = "off",
  num_workers = "1",
  port = "8123",
  name = "[DEVEL] readit",
  session_name = "my_app_session",
  secret = "A string witches also my s3cr3t!"
  track_exceptions = true
  sqlite = {
    database = "site.sqlite"
    -- open_falgs = ...
  }
})
