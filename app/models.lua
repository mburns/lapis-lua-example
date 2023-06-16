-- return require("lapis.util").autoload "models"

local Model = require("lapis.db.model").Model

local Users = Model:extend("users")

local autoload = require("lapis.util").autoload
return autoload("models")
