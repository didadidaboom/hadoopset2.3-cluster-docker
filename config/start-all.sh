#!/bin/bash

echo -e "\n"

$HADOOP_HOME/sbin/start-dfs.sh

echo -e "\n"

$HADOOP_HOME/sbin/start-yarn.sh

echo -e "\n"

mr-jobhistory-daemon.sh start historyserver

echo -e "\n"

$HBASE_HOME/bin/start-hbase.sh

echo -e "\n"

hdfs dfs -mkdir -p /spark-yarn/jars/
hdfs dfs -put /usr/local/spark/jars/* /spark-yarn/jars/
hdfs dfs -mkdir /spark-eventlog

echo -e "\n"

#$SPARK_HOME/sbin/start-all.sh
$SPARK_HOME/sbin/start-history-server.sh

