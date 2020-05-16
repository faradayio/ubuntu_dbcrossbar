# ubuntu_dbcrossbar

A docker container with dbcrossbar and related utils.

Useful if:

* you want to know how to install dependencies
* you are on a Mac and you want to avoid `The certificate was not trusted` errors (for otherwise valid certificates that Mac just won't accept)

## Quickstart

```
docker run \
  -e SRC_DATABASE_URL=$SRC_DATABASE_URL \
  -e DEST_DATABASE_URL=$DEST_DATABASE_URL \
  ubuntu_dbcrossbar \
  dbcrossbar cp \
    "$SRC_DATABASE_URL#src_table" \
    "$DEST_DATABASE_URL#dest_table" \
    --if-exists error \
    --where "message = 'hello world'"
```

## Copyright

Copyright 2020 Faraday
