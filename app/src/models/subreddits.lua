local db     = require "lapis.db"
local giflib = require "giflib"
-- local lfs    = require "lfs"
local magick = require "magick"
local Model  = require("lapis.db.model").Model

--- Create a board
-- @tparam table params Board parameters
-- @treturn boolean success
-- @treturn string error
function Subreddits :new(params)
end

--- Modify a board
-- @tparam table params Board parameters
-- @tparam old_name Board's current short name
-- @treturn boolean success
-- @treturn string error
function Subreddits :modify(params, old_name)
end

--- Delete a board
-- @tparam string name Board's short name
-- @treturn boolean success
-- @treturn string error
function Subreddits :delete(name)
end

--- Get all subreddits 
-- @treturn table subreddits 
function Subreddits :get_all()
	-- local subreddits  = self:select("order by subreddits .group asc, name asc")
	-- return subreddits  and subreddits  or false, "FIXME: ALART!"
end

--- Get board data
-- @tparam string name Board's short name
-- @treturn table board
function Subreddits :get(name)
	-- local board = self:find { name=name }
	-- return board and board or false, "FIXME: ALART!"
end

return Subreddits 