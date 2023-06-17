local lapis = require "lapis"
local r2    = require("lapis.application").respond_to
-- local config = require("lapis.config").get()
-- local csrf = require("lapis.csrf")
-- local db = require("lapis.db")

-- local capture_errors = require("lapis.application").capture_errors

local app   = lapis.Application()

app.include = function(self, a)
	self.__class.include(self, a, nil, self)
end

app:enable("etlua")
-- app.enable("exception_tracking")

app.layout = require "views.layout"

-- app:before_filter(function(self)
--   if self.session.user then
--     self.current_user = load_user(self.session.user)
--   end
-- end)

-- landing page
app:match("homepage", "/", r2(require "actions.index"))

-- test endpoints
app:match("health", "/health", function()
    return "Hello, " .. require("lapis.version")
end)

-- subreddits
app:get("subreddit", "/r/:subreddit", r2(require "actions.subreddit"))
app:match("/r/:subreddit/*", r2(require "actions.subreddit"))

-- user
app:match("user_profile", "/user/:username[%w]", r2(require "actions.user"))
app:match("user_comments", "/user/:username[%w]/comments", r2(require "actions.user"))
app:match("user_submitted", "/user/:username[%w]/submitted", function(self)
    print(self.params.username)
end)

return app
