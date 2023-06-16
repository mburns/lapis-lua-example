local lapis = require("lapis")
local config = require("lapis.config").get()
local csrf = require("lapis.csrf")
local db = require("lapis.db")

local capture_errors = require("lapis.application").capture_errors

local app = lapis.Application()
app:enable("etlua")
app.enable({ __base = app }, "exception_tracking")
app.layout = require "views.layout"

app:before_filter(function(self)
  if self.session.user then
    self.current_user = load_user(self.session.user)
  end
end)

-- app:include("apps.api")
-- app:include("apps.web")

-- homepage
app:get("homepage", "/", function()
  return "Welcome, " .. require("lapis.version")
end)

-- testing
app:match("/hello/:name", function(self)
  -- print(self.params.name)
  return { render = "hello" }
end)

-- submit a new post
app:match("submit", "/submit", function(self) end)

-- subreddits
app:match("subreddits", "/subreddits", function(self) end)
app:match("subreddit_search", "/subreddits/search", function(self) end)

-- subreddit
app:match("subreddit", "/r/:subreddit", function(self)
  -- print(self.params.subreddit)
end)
app:match("subreddit", "/r/:subreddit/*", function(self)
  -- print(self.params.subreddit)
  -- print(self.params.splat)
end)
app:match("post_page", "/r/:subreddit[%w]/comments/:post_id[%w]/:title_stub[%w]", function(self)
  -- print(self.params.subreddit)
  -- print(self.params.post_id)
  -- print(self.params.title_stub)
end)
app:match("duplicates_page", "/r/:subreddit[%w]/duplicates/:post_id[%d]/:title_stub[%w]", function(self)
  -- print(self.params.subreddit)
  -- print(self.params.post_id)
  -- print(self.params.title_stub)
end)

-- user
app:match("user_profile", "/user/:username[%w]", function(self)
  -- print(self.params.username)
end)
app:match("user_comments", "/user/:username[%w]/comments", function(self)
  -- print(self.params.username)
end)
app:match("user_submitted", "/user/:username[%w]/submitted", function(self)
  -- print(self.params.username)
end)
app:match("user_settings", "/settings/*[%w]", function(self)
  -- print(self.params.splat)
end)
app:match("user_preferences", "/prefs/*[%w]", function(self)
  -- print(self.params.splat)
end)

-- authentication
app:match("login", "/login", function(self)
  local csrf_token = csrf.generate_token(self)
  self:html(function()
    form({ method = "POST", action = self:url_for("form") }, function()
      input({ type = "hidden", name = "csrf_token", value = csrf_token })
      input({ type = "submit" })
    end)
  end)
end)

app:post("login", "/login", capture_errors(function(self)
  csrf.assert_token(self)
  return "The form is valid!"
end))

app:match("logout", "/logout", function(self) end)
app:match("password", "/password", function(self) end)

return app
