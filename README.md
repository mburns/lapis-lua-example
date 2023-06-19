```
docker run \
    -dti \
    -v "./data:/var/data" \
    -v "./app:/var/www" \
    -e LAPIS_ENV="development" \
    -p 8080:80 \
    --name example \
    --platform=linux/amd64 \
    karai17/lapis-centos:latest
```

Visit: http://localhost:8080/
