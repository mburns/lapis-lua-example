local db           = require "lapis.db"

return {
	before = function(self)
		-- Check if user is logged in

		-- Get all subs
		self.subreddits = db.select("* FROM ?", "__subreddits")
	end,

	GET = function(self)
		return { render = "subreddits" }
	end,
}
