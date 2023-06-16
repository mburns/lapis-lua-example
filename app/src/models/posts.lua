local encoding  = require "lapis.util.encoding"
local Model     = require("lapis.db.model").Model
local giflib    = require "giflib"
local magick    = require "magick"
local md5       = require "md5"
local filetypes = require "utils.file_whitelist"
local generate  = require "utils.generate"
-- local Posts     = Model:extend("posts", {
-- 	relations = {
-- 		{ "subreddit",  belongs_to="Subreddits" },
-- 		{ "post", belongs_to="Posts" },
-- 	}
-- })
local sf = string.format

--- Create a new post
-- @tparam table params Post parameters
-- @tparam table board Board data
-- @tparam boolean op OP flag
-- @treturn boolean success
-- @treturn string error
function Posts:new(params, board, op)
end

--- Delete post data
-- @tparam number id Post ID
-- @treturn boolean success
-- @treturn string error
function Posts:delete(id)
end

--- Get post data
-- @tparam number subreddit_id Subreddit ID
-- @tparam number post_id Local Post ID
-- @treturn table post
function Posts:get(subreddit_id, post_id)
	local post = self:find {
		subreddit_id = subreddit_id,
		post_id  = post_id
	}
	return post and post or false, "FIXME"
end

--- Get post data
-- @tparam number id Post ID
-- @treturn table post
function Posts:get_post_by_id(id)
	local post = self:find(id)
	return post and post or false, "FIXME"
end

--- Count posts in a thread
-- @tparam number thread_id Thread ID
-- @treturn number posts
function Posts:count_posts(thread_id)
	local sql = "thread_id=?"
	return self:count(sql, thread_id)
end

return Posts
