# readit

A better social link sharing website.

## TODO

- [ ] change the name
- [ ] user accounts w/csrf
- [ ] model relationships defined:
    * 1 User -> 1 Comment
    * many comments -> 1 Post
    * many posts -> 1 Subreddit
    * many subreddits -> 1 Subreddits listing
- [ ] Pages
  - [ ] `homepage`
  - [ ] `subreddit` landing page
  - [ ] `/submit` (per-subreddit)
  - [ ] `/login`, `/logout`, `/password`
  - [ ] `/subreddits/` `/subreddits/mine` listings pages
  - [ ] `prefs`, `settings`
- [ ] API (https://reddit.com/dev/api/)
- [ ] Sorting / parsing parameter arguments (`/r/.../top/?t=year`, `/popular`, `new`, `rising`, `controversial`, ~~`gilded`~~)
- [ ] RSS feed import/sync

## Development

From the root of the directory:

```
 docker run \
    -dti \
    -v "./data:/var/data" \
    -v "./app:/var/www" \
    -e LAPIS_ENV="development" \
    -p 8080:80 \
    --name readit \
    --platform=linux/amd64 \
    karai17/lapis-centos:latest
```

Then, visit: http://localhost:8080/

# Notes

* [Reddit Archive](https://github.com/reddit-archive/reddit)
* Built using [Lapis](https://leafo.net/lapis/) on [CentOS](https://github.com/karai17/lapis-centos) in [Lua v5.1](https://www.lua.org/manual/5.1/) using [OpenResty](https://openresty.org/)
