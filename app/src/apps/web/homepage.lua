local lapis    = require "lapis"
local r2       = require("lapis.application").respond_to
local app      = lapis.Application()

app.__base     = app
app.name       = "web.homepage."
-- app.handle_404 = require "apps.web.internal.code_404"-- user

-- homepage
app:get("homepage", "/", function()
    return "Welcome, " .. require("lapis.version")
end)

return app