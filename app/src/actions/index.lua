local db = require "lapis.db"

return {
	before = function(self)
		-- check if a table "example" exists
		self.q = db.query("SELECT name FROM sqlite_master WHERE type='table' AND name=?", "example")
	end,

	GET = function(self)
		return { render = "index" }
	end

}
