return {
	before = function(self)
		-- check if user exists

		-- check if user is logged in

		-- export user stats
	end,

	GET = function(self)
		return { render = "user" }
	end
}
