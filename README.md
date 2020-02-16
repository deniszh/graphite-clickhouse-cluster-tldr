## Testing Graphite-Clickhouse w/Clickhouse cluster

### What is it?

Preconfigured [graphite-web](https://github.com/graphite-project/graphite-web) (and [carbonapi](https://github.com/go-graphite/carbonapi)) with [ClickHouse](https://github.com/lomik/graphite-clickhouse-tldr) [cluster](https://github.com/jneo8/clickhouse-setup) backend deployed by docker-compose. Also contains Grafana and [Haggar](https://github.com/gorsuch/haggar). 
 
### Why?

[Similar repo](https://github.com/lomik/graphite-clickhouse-tldr) exists for single clickhouse server - this one also contains Zookeeper and configurable Clickhouse cluster. You can learn how Clickhouse cluster works and how graphite-clickhouse scales.

### WARNING

This repo is only an experiment and designed for learning and experiments. Please do not use it in production!

### Quick Start
```sh
git clone https://github.com/deniszh/graphite-clickhouse-cluster-test
cd graphite-clickhouse-cluster-test
./cleanup.sh
docker-compose up
```
Open http://127.0.0.1:3000/ in browser

### Mapped Ports

Host | Container | Service
---- | --------- | -------------------------------------------------------------------------------------------------------------------
  80 |        80 | graphite-web
3000 |      3000 | grafana
8080 |      8080 | carbonapi
9090 |      9090 | graphite-clickhouse
2003 |      2003 | carbon-clickhouse carbon plaintext tcp/udp
2004 |      2004 | carbon-clickhouse carbon pickle tcp
2006 |      2006 | carbon-clickhouse prometheus remote write
2181 |      2181 | zookeper
2182 |      2182 | zookeper
9999 |      9999 | zoonavigator


More details coming, prolly
