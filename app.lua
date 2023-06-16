local lapis = require("lapis")
local config = require("lapis.config").get()

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:before_filter(function(self)
  if self.session.user then
    self.current_user = load_user(self.session.user)
  end
end)

-- homepage
app:get("homepage", "/", function()
  return "Welcome, " .. tostring(self.current_user) .. ". " .. require("lapis.version")
end)

-- testing
app:match("/hello/:name", function(self)
  -- print(self.params.name)
  return { render = "hello" }
end)
app:get("/test", function(self)
  return "I only render for GET requests"
end)

-- submit a new post
app:match("submit", "/submit", function(self) end)

-- subreddits
app:match("subreddits", "/subreddits", function(self) end)
app:match("subreddit_search", "/subreddits/search", function(self) end)

-- subreddit
app:match("subreddit", "/r/:subreddit", function(self) end)
app:match("subreddit", "/r/:subreddit/:sort", function(self) end)
app:match("post_page", "/r/:subreddit[%w]/comments/:post_id[%w]/:title_stub[%w]", function(self) end)
app:match("duplicates_page", "/r/:subreddit[%w]/duplicates/:post_id[%d]/:title_stub[%w]", function(self) end)

-- user
app:match("user_profile", "/user/:username[%w]", function(self) end)
app:match("user_comments", "/user/:username[%w]/comments", function(self) end)
app:match("user_submitted", "/user/:username[%w]/submitted", function(self) end)
app:match("user_settings", "/settings/*[%w]", function(self) end)
app:match("user_preferences", "/prefs/*[%w]", function(self) end)

-- authentication
app:match("login", "/login", function(self) end)
app:match("logout", "/logout", function(self) end)
app:match("password", "/password", function(self) end)

return app
