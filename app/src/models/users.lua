local bcrypt = require "bcrypt"
-- local uuid   = require "resty.jit-uuid"
local config = require("lapis.config").get()
local Model  = require("lapis.db.model").Model
local token  = config.secret

local Users  = Model:extend("users")
-- local Users = Model:extend("users", {
-- 	constraints = {
-- 	  name = function(self, value)
-- 		if value:lower() == "admin" then
-- 		  return "User can not be named admin"
-- 		end
-- 	  end
-- 	}
-- })
  
--- Create a new user
-- @tparam table user User data
-- @treturn boolean success
-- @treturn string error
function Users:new(params, raw_password)

	-- Check if username is unique
	do
		local unique, err = self:is_unique(params.username)
		if not unique then return nil, err end
	end

	-- Verify password
	do
		local valid, err = self:validate_password(params.password, params.confirm, raw_password)
		if not valid then return nil, err end

		params.confirm  = nil
		params.password = bcrypt.digest(params.username:lower() .. params.password .. token, 12)
	end

	-- Generate unique API key
	-- do
	-- 	local api_key, err = self:generate_api_key()
	-- 	if not api_key then return nil, err end

	-- 	params.api_key = api_key
	-- end

	local user = self:create(params)
	return user and user or nil, { "err_create_user", { params.username } }
end

--- Modify a user
-- @tparam table user User data
-- @treturn boolean success
-- @treturn string error
function Users:modify(params, raw_username, raw_password)
end

--- Delete user
-- @tparam table user User data
-- @treturn boolean success
-- @treturn string error
function Users:delete(username)
	local user = self:get(username)
	if not user then
		return nil, "FIXME"
	end

	local success = user:delete()
	return success and user or nil, "FIXME"
end

--- Verify user
-- @tparam table params User data
-- @treturn boolean success
-- @treturn string error
function Users:login(params)
	local user = self:get(params.username)
	if not user then return nil, { "err_invalid_user" } end

	local password = user.username .. params.password .. token
	local verified = bcrypt.verify(password, user.password)

	return verified and user or nil, { "err_invalid_user" }
end

--- Get all users
-- @treturn table users List of users
function Users:get_all()
	local users = self:select("order by username asc")
	return users
end

--- Get user
-- @tparam string username Username
-- @treturn table user
function Users:get(username)
	local users = self:select("where lower(username)=? limit 1", username:lower())
	return #users == 1 and users[1] or nil, "FIXME"
end

function Users:is_unique(username)
	local user = self:get(username)
	return not user and true or nil, "FIXME", user
end

function Users.validate_password(_, password, confirm, old_password)
	if password ~= confirm or password ~= old_password then
		return nil, "FIXME"
	end

	return true
end

-- function Users:generate_api_key()
-- end

return Users