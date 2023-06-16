local config = require("lapis.config")

config("development", {
  server = "nginx",
  code_cache = "off",
  num_workers = "1",
  port = "8123",
  name = "lapis-example",
  session_name = "my_app_session",
  secret = "A string witches also my s3cr3t!",
  sqlite = {
    database = "site.sqlite"
    -- open_falgs = ...
  }
})
