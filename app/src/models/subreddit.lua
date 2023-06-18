local db     = require "lapis.db"
local date = db.format_date()

local Model = require("lapis.db.model").Model

local Subreddit = Model:extend("subreddit", {
	primary_key = "id",
	timestamp = true,
	relations = {
		{ "posts", has_many="Posts" },
		{ "moderators", has_many="Users" },
		{ "creator", has_one="Users" },
	}
})

--- Create a subreddit
-- @tparam table params Board parameters
-- @treturn boolean success
-- @treturn string error
function Subreddit:new(params)
	-- check if exists
	local subreddit = self:create(params)
	if not subreddit then
		return false, { "err_create_subreddit", { params.name, params.title } }
	end

	-- add to subreddits list
	db.insert("__subreddits", {
		name = params.name,
		description = "",
		created_at = date,
		creator_id = "",
		moderator_ids = "",
	})

	-- create subreddit table
	scehma.create_table(params.name, {
		{ "id",            types.integer { unique=true, primary_key=true }},
		{ "name",          types.text { unique=true }},
		{ "description",   types.text },
		{ "created_at",    types.integer },
		{ "deleted_at",    types.integer },
		{ "creator_id",    types.integer },
		{ "moderator_ids", types.text },
		{ "post_ids",      types.text },
		{ "post_count",    types.integer { unique=0 }},
		{ "comment_count", types.integer { unique=0 }}
	})

	return board
end

--- Modify a subreddit
-- @tparam table params Board parameters
-- @treturn boolean success
-- @treturn string error
function Subreddit:modify(params)
	-- TODO
end

--- Delete a subreddit
-- @tparam string name Board's short name
-- @treturn boolean success
-- @treturn string error
function Subreddit:delete(name)
	-- validate a reasonable name to delete
	if not name or name == "" then
		return false, "FIXME: invalid subreddit name"
	end

	-- delete from subreddits list
	db.delete("__subreddits", {
		name = name
	})

	-- drop subreddit table
	schema.drop_table(name .. "_posts")
	schema.drop_table(name .. "_comments")
	schema.drop_table(name .. "_votes")
end

--- Get subreddit data
-- @tparam string name Board's short name
-- @treturn table subreddit
function Subreddit:get(name)
	local subreddit = self:find { name=name }
	return subreddit and subreddit or false, "FIXME: subreddit not found!"
end

return Subreddit
