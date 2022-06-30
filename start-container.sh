#!/bin/bash

# the default node number is 3
N=${1:-3}


# start mysql container
sudo docker rm -f hadoop-mysql &> /dev/null
echo "start hadoop-mysql container..."
sudo docker run -itd \
                --net=hadoop \
                --name hadoop-mysql \
               --hostname hadoop-mysql \
		-e MYSQL_ROOT_PASSWORD=hive \
                mysql &> /dev/null

# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
		-p 10000:10000 \
		-p 9083:9083 \
		-p 10020:10020 \
		-p 19888:19888 \
		-p 18080:18080 \
		-p 8020:8020 \
		-p 7077:7077 \
		-p 8022:22 \
		-p 16010:16010 \
                -p 50070:50070 \
                -p 8088:8088 \
		-p 8888:8888 \
		-p 8080:8080 \
		-p 9000:9000 \
                --name hadoop-master \
                --hostname hadoop-master \
                didadidaboom/hadoopset:2.3 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                didadidaboom/hadoopset:2.3 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
