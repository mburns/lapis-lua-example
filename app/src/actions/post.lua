local db = require("lapis.db")

return {
	before = function(self)
		-- Check if user is logged in

		-- Get comments

		-- Check if subreddit is nil or empty
		local name = self.params.subreddit
		if name == nil or name == '' then
			print("Subreddit is unknown: " .. name)
			return self:write({ redirect_to = self:url_for("homepage") })
		end

		local sub_comments_table = name .. "_comments"
		self.comments = db.select("* FROM ? WHERE post_id = ?", sub_comments_table, self.params.post_id)
	end,

	GET = function(self)
		return { render = "post" }
	end
}
