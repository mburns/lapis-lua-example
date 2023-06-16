local lapis    = require "lapis"
local r2       = require("lapis.application").respond_to
local app      = lapis.Application()

app.__base     = app
app.name       = "web.auth."
-- app.handle_404 = require "apps.web.internal.code_404"-- user

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