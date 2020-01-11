#!/bin/bash -x
rm -rf data/*
mkdir -p data/carbon-clickhouse
mkdir -p data/grafana
mkdir -p data/graphite-clickhouse
mkdir -p data/zk001/{data,datalog,logs}
mkdir -p data/ch01/{data,metadata,log}
mkdir -p data/ch02/{data,metadata,log}
mkdir -p data/ch03/{data,metadata,log}
mkdir -p data/ch04/{data,metadata,log}
mkdir -p data/ch05/{data,metadata,log}
mkdir -p data/ch06/{data,metadata,log}

