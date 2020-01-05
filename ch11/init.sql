CREATE TABLE IF NOT EXISTS default.graphite_opt (
    `Path` LowCardinality(String),
    `Value` Float64 CODEC(Gorilla, ZSTD(1)),
    `Time` UInt32 CODEC(DoubleDelta, LZ4),
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Timestamp` UInt32 CODEC(DoubleDelta, LZ4)
) ENGINE = GraphiteMergeTree('graphite_rollup')
PARTITION BY toYYYYMM(Date)
ORDER BY (Path, Time);

CREATE TABLE IF NOT EXISTS default.graphite_index_opt (
    `Date` Date CODEC(DoubleDelta, LZ4),
    `Level` UInt32 CODEC(DoubleDelta, LZ4),
    `Path` LowCardinality(String),
    `Version` UInt32 CODEC(DoubleDelta, LZ4)
) ENGINE = ReplacingMergeTree(Version)
PARTITION BY toYYYYMM(Date)
ORDER BY (Level, Path, Date);

CREATE TABLE IF NOT EXISTS default.graphite_tagged_opt (
      Date Date CODEC(DoubleDelta, LZ4),
      Tag1 LowCardinality(String),
      Path LowCardinality(String),
      Tags Array(LowCardinality(String)),
      Version UInt32 CODEC(Delta, LZ4),
      Deleted UInt8 CODEC(Delta, LZ4)
) ENGINE = ReplacingMergeTree(Version)
PARTITION BY toYYYYMM(Date)
ORDER BY (Tag1, Path, Date);
