FROM ubuntu:18.04

MAINTAINER didadidaboom <chong.wu.sg@outlook.com>

WORKDIR /root

# install openssh-server, openjdk and wget
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && \
    apt-get install -y openssh-server openssh-client openjdk-8-jdk wget vim python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install jupyter virtualenv && \
    virtualenv -p /usr/bin/python3 reco_sys

# install hadoop 2.7.2 and hive
RUN wget https://github.com/kiwenlau/compile-hadoop/releases/download/2.7.2/hadoop-2.7.2.tar.gz && \
    tar -xzvf hadoop-2.7.2.tar.gz && \
    mv hadoop-2.7.2 /usr/local/hadoop && \
    rm hadoop-2.7.2.tar.gz && \ 
    wget https://archive.apache.org/dist/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz && \
    tar -xzvf apache-hive-2.3.7-bin.tar.gz && \ 
    mv apache-hive-2.3.7-bin /usr/local/hive && \
    rm apache-hive-2.3.7-bin.tar.gz && \
    rm -rf /usr/local/hadoop/share/hadoop/common/lib/guava-11.0.2.jar && \
    cp /usr/local/hive/lib/guava-14.0.1.jar /usr/local/hadoop/share/hadoop/common/lib/ && \
    wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.16/mysql-connector-java-8.0.16.jar && \
    mv mysql-connector-java-8.0.16.jar /usr/local/hive/lib/mysql-connector-java.jar && \
    wget https://archive.apache.org/dist/hbase/1.4.7/hbase-1.4.7-bin.tar.gz && \
    tar -xzvf hbase-1.4.7-bin.tar.gz && \
    mv hbase-1.4.7 /usr/local/hbase && \
    rm hbase-1.4.7-bin.tar.gz && \ 
    wget https://archive.apache.org/dist/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz && \
    tar -xzvf spark-2.4.5-bin-hadoop2.7.tgz && \
    mv spark-2.4.5-bin-hadoop2.7 /usr/local/spark && \ 
    rm spark-2.4.5-bin-hadoop2.7.tgz && \
    cp /usr/local/hive/lib/hive-beeline-2.3.7.jar /usr/local/spark/jars/hive-beeline-2.3.7.jar && \
    cp /usr/local/hive/lib/hive-cli-2.3.7.jar /usr/local/spark/jars/hive-cli-2.3.7.jar && \
    cp /usr/local/hive/lib/hive-exec-2.3.7.jar /usr/local/spark/jars/hive-exec-2.3.7.jar && \
    cp /usr/local/hive/lib/hive-jdbc-2.3.7.jar /usr/local/spark/jars/hive-jdbc-2.3.7.jar && \
    cp /usr/local/hive/lib/hive-metastore-2.3.7.jar /usr/local/spark/jars/hive-metastore-2.3.7.jar && \
    wget http://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    tar -xzvf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    mv sqoop-1.4.7.bin__hadoop-2.6.0 /usr/local/sqoop && \
    rm sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    cp /usr/local/hive/lib/mysql-connector-java.jar /usr/local/sqoop/lib/mysql-connector-java.jar && \
    cp /usr/local/spark/jars/spark-network-common_2.11-2.4.5.jar /usr/local/hive/lib/spark-network-common_2.11-2.4.5.jar && \ 
    cp /usr/local/spark/jars/spark-core_2.11-2.4.5.jar /usr/local/hive/lib/spark-core_2.11-2.4.5.jar && \
    cp /usr/local/spark/jars/scala-library-2.11.12.jar /usr/local/hive/lib/scala-library-2.11.12.jar && \ 
    cp /usr/local/spark/jars/chill-java-0.9.3.jar /usr/local/hive/lib/chill-java-0.9.3.jar && \ 
    cp /usr/local/spark/jars/chill_2.11-0.9.3.jar /usr/local/hive/lib/chill_2.11-0.9.3.jar && \
    cp /usr/local/spark/jars/jackson-module-paranamer-2.7.9.jar /usr/local/hive/lib/jackson-module-paranamer-2.7.9.jar && \
    cp /usr/local/spark/jars/jackson-module-scala_2.11-2.6.7.1.jar /usr/local/hive/lib/jackson-module-scala_2.11-2.6.7.1.jar && \
    cp /usr/local/spark/jars/jersey-container-servlet-core-2.22.2.jar /usr/local/hive/lib/jersey-container-servlet-core-2.22.2.jar && \
    cp /usr/local/spark/jars/jersey-server-2.22.2.jar /usr/local/hive/lib/jersey-server-2.22.2.jar && \
    cp /usr/local/spark/jars/json4s-ast_2.11-3.5.3.jar /usr/local/hive/lib/json4s-ast_2.11-3.5.3.jar && \
    cp /usr/local/spark/jars/kryo-shaded-4.0.2.jar /usr/local/hive/lib/kryo-shaded-4.0.2.jar && \
    cp /usr/local/spark/jars/minlog-1.3.0.jar /usr/local/hive/lib/minlog-1.3.0.jar && \
    cp /usr/local/spark/jars/scala-xml_2.11-1.0.5.jar /usr/local/hive/lib/scala-xml_2.11-1.0.5.jar && \
    cp /usr/local/spark/jars/spark-launcher_2.11-2.4.5.jar /usr/local/hive/lib/spark-launcher_2.11-2.4.5.jar && \
    cp /usr/local/spark/jars/spark-network-shuffle_2.11-2.4.5.jar /usr/local/hive/lib/spark-network-shuffle_2.11-2.4.5.jar && \
    cp /usr/local/spark/jars/spark-unsafe_2.11-2.4.5.jar /usr/local/hive/lib/spark-unsafe_2.11-2.4.5.jar && \
    cp /usr/local/spark/jars/xbean-asm6-shaded-4.8.jar /usr/local/hive/lib/xbean-asm6-shaded-4.8.jar

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 
ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin 
ENV HIVE_HOME=/usr/local/hive
ENV PATH=$PATH:/usr/local/hive/bin
ENV HBASE_HOME=/usr/local/hbase
ENV PATH=$PATH:/usr/local/hbase/bin
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:/usr/local/spark/bin
ENV JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre
ENV CLASSPATH=.:$JAVE_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV SQOOP_HOME=/usr/local/sqoop
ENV PATH=$PATH:/usr/local/sqoop/bin
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HDFS_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    echo root:ubuntu|chpasswd && \
    echo "PermitRootLogin yes">>/etc/ssh/sshd_config

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs && \
    mkdir -p $HIVE_HOME/tmp/hive/java && \
    mkdir -p ~/hdfs/hbase

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    cp /tmp/yarn-site.xml $SPARK_HOME/conf/yarn-site.xml && \
    cp /tmp/hdfs-site.xml $SPARK_HOME/conf/hdfs-site.xml && \
    cp /tmp/hive-site.xml $SPARK_HOME/conf/hive-site.xml && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/yarn-env.sh $HADOOP_HOME/etc/hadoop/yarn-env.sh && \
    cp /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    mv /tmp/hive-env.sh $HIVE_HOME/conf/hive-env.sh && \
    mv /tmp/hive-site.xml $HIVE_HOME/conf/hive-site.xml && \
    mv /tmp/hbase-env.sh $HBASE_HOME/conf/hbase-env.sh && \
    mv /tmp/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml && \
    mv /tmp/regionservers $HBASE_HOME/conf/regionservers && \
    mv /tmp/start-all.sh ~/start-all.sh && \
    mv /tmp/stop-all.sh ~/stop-all.sh && \
    mv /tmp/start-ssh.sh ~/start-ssh.sh && \
    mv /tmp/sqoop-env.sh $SQOOP_HOME/conf/sqoop-env.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh && \
    chmod +x ~/start-all.sh && \
    chmod +x ~/start-ssh.sh

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash", "/usr/sbin/sshd","-D"]
