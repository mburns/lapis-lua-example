local db     = require "lapis.db"
local schema = require("lapis.db.schema")
local types  = schema.types

-- add each incremental migration whose key is the unix timestamp
return {
  [1] = function()
    schema.create_table("__users", {
      { "id",             types.integer { unique=true, primary_key=true }},
      { "name",           types.text    { unique=true }},
      { "email",          types.text },

      { "created_at",     types.integer { default="1970-01-01 00:00:00" }},
      { "deleted_at",     types.integer { null=true }},
      { "over_18",        types.integer { default=false }},
      { "verified_email", types.integer { default=false }}
    })

    schema.create_table("__subreddits", {
      { "id",            types.integer { unique=true, primary_key=true }},
      { "name",          types.text { unique=true }},

      { "created_at",    types.integer { default="1970-01-01 00:00:00" }},
      { "creator_id",    types.integer { deafault=1 }},
      { "deleted_at",    types.integer { null=true }},
      { "description",   types.text { null=true }},
      { "moderator_ids", types.text { null=true }},
      { "nsfw",          types.integer { default=false }}
    })
  end,

  [2] = function()
    -- create the first user
    db.insert("__users", {
      name = "anonymous_coward",
      email = "anonymous_coward@localhost"
    })

    -- create the deafult subreddit
    db.insert("__subreddits", {
      name = "meta",
      creator_id = 1 -- TODO dynamically discover the user id
    })

    -- create first subreddit's Posts table, containing Posts by Users
    schema.create_table("meta_posts", {
      { "id",                  types.integer { unique=true, primary_key=true }},
      { "user_id",             types.integer },
      { "title",               types.text },
      { "permalink",           types.text    { unique=true }},
      { "url",                 types.text    { null=true }},
  
      { "locked",              types.integer { default=false }},
      { "created_utc",         types.integer { default="1970-01-01 00:00:00" }},
      { "edited",              types.integer { default=false }},
      { "is_self",             types.integer { default=false }},
      { "over_18",             types.integer { default=false }},
      { "body",                types.text    { null=true }}
    })

    -- create first subreddit's Comments table, containing Comments by Users
    schema.create_table("meta_comments", {
      { "id",                types.integer { unique=true, primary_key=true }},
      { "post_id",           types.integer },
      { "user_id",           types.integer },
      { "parent_comment_id", types.integer { null=true }},
      { "body",              types.text },
  
      -- { "permalink",       types.test { null=true }},
      { "created_utc",       types.integer { default="1970-01-01 00:00:00" }},
      { "edited",            types.integer { default=0 }},
      { "is_submitter",      types.integer { default=false }},
      { "stickied",          types.integer { default=false }}
    })

    -- create first subreddit's Votes table, containing Votes on Posts or Comments by Users
    schema.create_table("meta_votes", {
      { "id",                types.integer { unique=true, primary_key=true }},
      { "user_id",           types.integer },
      { "post_id",           types.integer },
      { "comment_id",        types.integer { null=true }},
      { "upvote",            types.integer { default=true }}
    })
  end,

  [3] = function()
    -- first post
    db.insert("meta_posts", {
      user_id = 1, -- TODO dynamically discover the user id
      permalink = "/", -- TODO generate permalink
      title = "test post please ignore",
      is_self = true,
      body = ""
    })
  end,

  [4] = function()
    -- first comment
    db.insert("meta_comments", {
      post_id      = 1,
      user_id      = 1,
      body         = "test comment please ignore",
      -- created_utc = os.time(),
      is_submitter = true
    })
  end,

  [5] = function()
    -- first vote on post
    db.insert("meta_votes", {
      user_id = 1,
      post_id = 1,
      upvote  = true
    })

    -- first vote on comment
    db.insert("meta_votes", {
      user_id    = 1,
      post_id    = 1,
      comment_id = 1,
      upvote     = true
    })

  end,

  -- TODO: https://github.com/leafo/lapis-exceptions
  -- [1439944992] = require("lapis.exceptions.schema").run_migrations
}
