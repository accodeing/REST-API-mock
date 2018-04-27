# Building

Run `docker build -t faker .` in the same directory where you find the `Dockerfile` and `nginx.conf`.

# Running

Given a directory structure like:

```
  ./
    Dockerfile
    nginx.conf
    /data
      /api
        /files
          2bc3994a98b.json
          index.json
      /bin
        /files
          2bc3994a98b.png
```

To start the server and use the data directory for the API just run:

```
docker
  run
  --name faker
  -p 8080:8080
  --mount type=bind,source="$(pwd)"/data,target=/usr/share/nginx/html
  -it
  faker
```

Run `docker rm faker` if you get an error about the container name already being in use.

# Extending

If you want to bake the data into the image you need to edit the `Dockerfile` and uncomment/edit the line: `COPY data /usr/share/nginx/html` to match what directory you want to add.

The added data should result in two directories, `/usr/share/nginx/html/api` and `/usr/share/nginx/html/bin`, being added to the image.

Anything under `/api` should be folders with `index.json` and `[id].json` files to be served for requests like: `http://localhost/api/files` (`/api/files/index.json`) or `http://localhost/api/files/[id]` (`/api/files/[id].json`). These will all be served with a mime type of `application/json`.

Under `/bin` everything will be served with a default mime type of `application/octet-stream` or a compatible binary mime type appropriate for the file. The structure here is up to you, it is just for serving static files.
