-- local db     = require "lapis.db"
local schema = require("lapis.db.schema")
local types  = schema.types

-- add each incremental migration whose key is the unix timestamp
return {
  [1] = function()

    schema.create_table("subreddits", {
      { "id", types.serial },
      { "name", types.text },
      { "description", types.text },
      { "created_at", types.integer },
      { "deleted_at", types.integer },
      { "creator_id", types.integer },
      { "moderator_ids", types.text },
      { "post_ids", types.text },
      { "post_count", types.integer },
      { "comment_count", types.integer },
      "PRIMARY KEY (id)"
    })

    schema.create_table("posts", {
      { "id", types.serial },
      { "author", types.text },
      { "title", types.text },
      { "url", types.text },
      { "permalink", types.text },
      { "selftext", types.text },
      { "author_flair_text", types.text },
      { "link_flair_text", types.text },

      { "created_utc", types.integer },
      { "edited", types.integer },
      { "ups", types.integer },
      { "downs", types.integer },
      { "score", types.integer },

      { "upvote_ratio", types.real },
      { "num_comments", types.integer },

      { "archived", types.boolean },
      { "is_self", types.boolean },
      { "is_original_content", types.boolean },
      { "is_video", types.boolean },
      { "over_18", types.boolean },

      "PRIMARY KEY (id)"
    })

    schema.create_table("comments", {
      { "id", types.serial },
      { "author", types.text },
      { "author_flair_text", types.text },
      { "body", types.text },
      { "parent_comment_id", types.integer },
      { "post_id", types.integer },
      { "root", types.boolean },
      { "created_utc", types.integer },
      { "edited", types.integer },
      { "score", types.integer },
      { "ups", types.integer },
      { "downs", types.integer },
      { "controversiality", types.real },
      { "is_submitter", types.boolean },
      { "stickied", types.boolean },
      "PRIMARY KEY (id)"
    })

    schema.create_table("users", {
      { "id", types.serial },
      { "name", types.text },
      { "email", types.text },
      { "verified_email", types.boolean },
      { "created_at", types.integer },
      { "deleted_at", types.integer },
      { "karma", types.integer },
      { "comment_karma", types.integer },
      { "link_karma", types.integer },
      { "is_gold", types.boolean { default=false }},
      { "is_mod", types.boolean { default=false }},
      "PRIMARY KEY (id)"
    })
  end,

  [1439944992] = require("lapis.exceptions.schema").run_migrations
}
