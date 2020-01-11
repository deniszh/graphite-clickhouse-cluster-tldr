CREATE DATABASE IF NOT EXISTS graphite;

CREATE TABLE IF NOT EXISTS graphite.data (
    `Path` LowCardinality(String),
    `Value` Float64 CODEC(Gorilla, ZSTD(1)),
    `Time` UInt32 CODEC(DoubleDelta, LZ4),
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Timestamp` UInt32 CODEC(DoubleDelta, LZ4)
) ENGINE = ReplicatedGraphiteMergeTree('/clickhouse/tables/{shard}/graphite.data', '{replica}', 'graphite_rollup')
PARTITION BY toYYYYMM(Date)
ORDER BY (Path, Time);

CREATE TABLE IF NOT EXISTS graphite.data_dist (
    `Path` LowCardinality(String),
    `Value` Float64 CODEC(Gorilla, ZSTD(1)),
    `Time` UInt32 CODEC(DoubleDelta, LZ4),
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Timestamp` UInt32 CODEC(DoubleDelta, LZ4)
) ENGINE = Distributed(graphite_ch, graphite, data, cityHash64(Path));

CREATE TABLE IF NOT EXISTS graphite.index (
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Level` UInt32 CODEC(DoubleDelta, LZ4),
    `Path` LowCardinality(String),
    `Version` UInt32 CODEC(DoubleDelta, LZ4)
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{shard}/graphite.index', '{replica}', Version)
PARTITION BY toYYYYMM(Date)
ORDER BY (Level, Path, Date);

CREATE TABLE IF NOT EXISTS graphite.index_dist (
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Level` UInt32 CODEC(DoubleDelta, LZ4),
    `Path` LowCardinality(String),
    `Version` UInt32 CODEC(DoubleDelta, LZ4)
) ENGINE = Distributed(graphite_ch, graphite, index, cityHash64(Path));

CREATE TABLE IF NOT EXISTS graphite.tagged (
      Date Date CODEC(DoubleDelta, LZ4),
      Tag1 LowCardinality(String),
      Path LowCardinality(String),
      Tags Array(LowCardinality(String)),
      Version UInt32 CODEC(Delta, LZ4),
      Deleted UInt8 CODEC(Delta, LZ4)
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{shard}/graphite.tagged', '{replica}', Version)
PARTITION BY toYYYYMM(Date)
ORDER BY (Tag1, Path, Date);

CREATE TABLE IF NOT EXISTS graphite.tagged_dist (
      Date Date CODEC(DoubleDelta, LZ4),
      Tag1 LowCardinality(String),
      Path LowCardinality(String),
      Tags Array(LowCardinality(String)),
      Version UInt32 CODEC(Delta, LZ4),
      Deleted UInt8 CODEC(Delta, LZ4)
) ENGINE = Distributed(graphite_ch, graphite, tagged, cityHash64(Path,Tags));
