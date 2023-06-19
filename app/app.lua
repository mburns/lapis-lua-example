local lapis = require "lapis"
local r2 = require("lapis.application").respond_to
local app = lapis.Application()

app:enable("etlua")

app.layout = require "views.layout"

app:match("/", r2(require "actions.index"))

return app
