local lapis = require "lapis"
local r2    = require("lapis.application").respond_to
-- local config = require("lapis.config").get()
-- local csrf = require("lapis.csrf")
-- local db = require("lapis.db")

-- local capture_errors = require("lapis.application").capture_errors

local app   = lapis.Application()

-- app.include = function(self, a)
-- 	self.__class.include(self, a, nil, self)
-- end

app:enable("etlua")

app.layout = require "views.layout"

app:before_filter(function(self)
  if self.session.user then
    self.current_user = load_user(self.session.user)
  end
end)

app:match("homepage",  "/",                       r2(require "actions.index"))
app:match("subreddits", "/subreddits(/:type)",    r2(require "actions.subreddits"))
app:match("subreddit", "/r/:subreddit[%w](/:sort)",   r2(require "actions.subreddit"))
app:match("profile",   "/user/:user(/:type)", r2(require "actions.user"))

app:match("post", "/r/:subreddit/comments/:post_id[%w](/:title_stub)", r2(require "actions.post"))

app:match("password", "/password", function(self) end) -- stub
app:match("login",    "/login",    function(self) end) -- stub
app:match("logout",   "/logout",   function(self)
	-- Logout
	self.session.user  = nil
	self.session.admin = nil
	self.session.mod   = nil

	return { redirect_to = self:url_for("homepage") }
end)

app:match("health", "/health", function()
  return "Hello, " .. require("lapis.version")
end)

return app
