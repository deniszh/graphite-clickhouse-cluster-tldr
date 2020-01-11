#!/bin/sh

docker-compose exec clickhouse-01 bash -c "
    export HOME=/var/lib/clickhouse/
    exec clickhouse client
"