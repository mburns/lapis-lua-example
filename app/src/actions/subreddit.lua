-- local assert_error = require("lapis.application").assert_error
-- local assert_valid = require("lapis.validate").assert_valid
-- local csrf         = require "lapis.csrf"
local db     = require "lapis.db"
local schema = require("lapis.db.schema")
local types  = schema.types

return {
	before = function(self)
		local name = self.params.subreddit

		local posts_table    = name .. "_posts"
		local comments_table = name .. "_comments"
		local votes_table    = name .. "_votes"

		-- Check if subreddit is nil or empty
		if name == nil or name == '' then
			print("Subreddit is unknown: " .. name)
			return self:write({ redirect_to = self:url_for("homepage") })
		end
	
		-- Check if sub exist in subreddits table
		local should_exist = db.query("SELECT name FROM __subreddits WHERE name=?", name)
		require 'pl.pretty'.dump(should_exist)
		if next(should_exist) == nil then
			print "Subreddit not found"
			return self:write({ redirect_to = self:url_for("homepage") })
		-- else
		-- 	print("Subreddit found for " .. name)
		end

		-- Check if tables exist
		-- TODO this should be done in the subreddit(s) model, with a :create_subreddit(name, opts) method
		local does_exist = db.query("SELECT name FROM sqlite_master WHERE type='table' AND name=?", posts_table)
		require 'pl.pretty'.dump(does_exist)
		if next(does_exist) == nil then
			print("creating tables for " .. name)
			-- create each subreddit table containing Posts by Users
			schema.create_table(posts_table, {
				{ "id",                  types.integer { unique=true, primary_key=true }},
				{ "author",              types.text },
				{ "permalink",           types.text    { unique=true }},
				{ "title",               types.text },
				{ "url",                 types.text },

				{ "locked",              types.integer { default=false }},
				{ "created_utc",         types.integer { default="1970-01-01 00:00:00" }},
				{ "edited",              types.integer { default=false }},
				{ "is_self",             types.integer { default=false }},
				{ "over_18",             types.integer { default=false }},
				{ "body",                types.text    { null=true }}
			})

			-- create each subreddit table containing Comments by Users
			schema.create_table(comments_table, {
				{ "id",                types.integer { unique=true, primary_key=true }},
				{ "post_id",           types.integer },
				{ "user_id",           types.integer },
				{ "parent_comment_id", types.integer { null=true }},
				{ "body",              types.text },
		
				{ "created_utc",       types.integer { default="1970-01-01 00:00:00" }},
				{ "edited",            types.integer { default=0 } },
				{ "is_submitter",      types.integer { default=false }},
				{ "stickied",          types.integer { default=false }}
			})

			-- create each subreddit table containing Votes on Posts or Comments by Users
			schema.create_table(votes_table, {
				{ "id",                types.integer { unique=true, primary_key=true }},
				{ "user_id",           types.integer },
				{ "post_id",           types.integer },
				{ "comment_id",        types.integer { null=true }},
				{ "upvote",            types.integer { default=true }}
			})
		-- else
		-- 	print("tables already exist for " .. name)
		end

		self.posts = db.select("* FROM ?", posts_table)
	end,

	-- https://github.com/karai17/lapis-chan/blob/master/app/src/utils/generate.lua
	-- on_error = function(self)
	-- 	self.errors = generate.errors(self.i18n, self.errors)
	-- 	return { render = "subreddit"}
	-- end,

	GET = function(self)
		return { render = "subreddit" }
	end,
}
