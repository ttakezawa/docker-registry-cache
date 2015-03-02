#!/bin/bash

export CACHE_REDIS_HOST=${CACHE_REDIS_HOST:-127.0.0.1}
export CACHE_REDIS_PORT=${CACHE_REDIS_PORT:-6379}
export CACHE_LRU_REDIS_HOST=${CACHE_LRU_REDIS_HOST:-127.0.0.1}
export CACHE_LRU_REDIS_PORT=${CACHE_LRU_REDIS_PORT:-6379}

CACHE_REDIS_MAXMEMORY=${CACHE_REDIS_MAXMEMORY:-20mb}

# redis config
cat << EOF >> /etc/redis.conf
daemonize yes
maxmemory ${CACHE_REDIS_MAXMEMORY}
maxmemory-policy allkeys-lru
EOF

# start redis
/usr/bin/redis-server /etc/redis.conf

# workaround https://github.com/docker/docker-registry/issues/892
export GUNICORN_OPTS="[--preload]"
docker-registry
