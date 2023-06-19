local schema = require("lapis.db.schema")
local types  = schema.types

return {
  [1] = function()
    schema.create_table("example", {
      { "id", types.integer { unique=true, primary_key=true }},
      { "name", types.text { unique=true }}
    })
  end
}
