local lapis    = require "lapis"
local r2       = require("lapis.application").respond_to
local app      = lapis.Application()

app.__base     = app
app.name       = "web.users."
-- app.handle_404 = require "apps.web.internal.code_404"-- user

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

return app