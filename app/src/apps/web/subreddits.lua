local lapis    = require "lapis"
local r2       = require("lapis.application").respond_to
local app      = lapis.Application()

app.__base     = app
app.name       = "web.subreddits."
-- app.handle_404 = require "apps.web.internal.code_404"

-- subreddits
app:match("subreddits", "/subreddits", function(self) end)
app:match("subreddit_search", "/subreddits/search", function(self) end)

-- subreddit
app:match("subreddit", "/r/:subreddit", function(self)
    -- print(self.params.subreddit)
end)
app:match("subreddit", "/r/:subreddit/*", function(self)
    print(self.params.subreddit)
    -- print(self.params.splat)
end)
app:match("post_page", "/r/:subreddit[%w]/comments/:post_id[%w]/:title_stub[%w]", function(self)
    print(self.params.subreddit)
    print(self.params.post_id)
    print(self.params.title_stub)
end)
app:match("duplicates_page", "/r/:subreddit[%w]/duplicates/:post_id[%d]/:title_stub[%w]", function(self)
    print(self.params.subreddit)
    print(self.params.post_id)
    print(self.params.title_stub)
end)

return app