## Graphite-Clickhouse w/Clickhouse cluster Testing / TLDR

### What is it?

Preconfigured [graphite-web](https://github.com/graphite-project/graphite-web) (and [carbonapi](https://github.com/go-graphite/carbonapi)) with [ClickHouse](https://github.com/lomik/graphite-clickhouse-tldr) [cluster](https://github.com/jneo8/clickhouse-setup) backend deployed by docker-compose. Also contains Grafana and [Haggar](https://github.com/gorsuch/haggar). 
 
### Why?

[Similar repo](https://github.com/lomik/graphite-clickhouse-tldr) exists for single clickhouse server - this one also contains Zookeeper and configurable Clickhouse cluster. You can learn how Clickhouse cluster works and how graphite-clickhouse scales.

### WARNING

This repo is only an experiment and designed for learning and experiments. Please do not use it in production!

### Clickhouse cluster

Clickhouse cluster consists of 6 nodes, 3 shards x 2 replicas. 

So, shards = [ch01/ch06], [ch02/03], [ch04/05]. 
Or, from replicas side of view - [ch01/ch02/ch04], [ch06/ch03/ch05]

Do not forget to sync proxy config `chproxy/config.yml` with real cluster config in `ch/config/macros` and `ch/config/clickhouse_metrika.xml`

Also do not forget to rerun `docker-compose build` after changing `chproxy/config.yml`.

### TODO

Chaos (using Pumba) - with metric delay and availability monitoring.

### Quick Start
```sh
git clone https://github.com/deniszh/graphite-clickhouse-cluster-test
cd graphite-clickhouse-cluster-test
./cleanup.sh
docker-compose build
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
9099 |      9099 | chproxy
9999 |      9999 | zoonavigator

