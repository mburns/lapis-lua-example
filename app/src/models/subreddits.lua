local db     = require "lapis.db"
local date = db.format_date()

local Model = require("lapis.db.model").Model
local Subreddits = Model:extend("subreddits")

--- Get all subreddits
-- @treturn table subreddits
function Subreddits:get_all()
	local subreddits = self:select("order by name asc")
	return subreddits and subreddits or false, "FIXME: listing subreddits failed"
end

return Subreddits 