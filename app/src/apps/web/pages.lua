local lapis    = require "lapis"
local r2       = require("lapis.application").respond_to
local app      = lapis.Application()

app.__base     = app
app.name       = "web.pages."
-- app.handle_404 = require "apps.web.internal.code_404"

app:include("apps.web.admin")
app:include("apps.web.auth")
app:include("apps.web.pages")
app:include("apps.web.subreddits")
app:include("apps.web.users")
app:include("apps.web.homepage")

-- submit a new post
app:match("submit", "/submit", function(self) end)

return app