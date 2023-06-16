local lapis = require("lapis")
local config = require("lapis.config").get()
local csrf = require("lapis.csrf")
local db = require("lapis.db")

local capture_errors = require("lapis.application").capture_errors

local app = lapis.Application()

-- app.include = function(self, a)
-- 	self.__class.include(self, a, nil, self)
-- end

app:enable("etlua")
app.enable({ __base = app }, "exception_tracking")
  app.layout = require "views.layout"

-- app:before_filter(function(self)
--   if self.session.user then
--     self.current_user = load_user(self.session.user)
--   end
-- end)

app:get("/example", function()
  return "Welcome, " .. require("lapis.version")
end)

-- app:include("apps.api")
-- app:include("apps.web")

return app
