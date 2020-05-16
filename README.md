# ubuntu_dbcrossbar

A docker container with dbcrossbar and related utils.

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