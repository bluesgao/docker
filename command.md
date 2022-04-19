## docker常用命令
docker network ls
docker ps
docker inspect 容器id
docker inspect mysql | grep IPAddress
docker logs 容器id
docker cp ./admin.sql 容器id:/tmp/
docker exec -it 容器id /bin/bash

## docker部署nacos+mysql
https://blog.csdn.net/zhaoydzhaoyd/article/details/105792964

docker run --env MODE=standalone --name nacos -d -p 8848:8848 nacos/nacos-server

docker run -itd --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=nacos mysql:5.7.29

docker run -d -e MODE=standalone -e SPRING_DATASOURCE_PLATFORM=mysql -e MYSQL_SERVICE_HOST=172.17.0.2 -e MYSQL_SERVICE_PORT=3306 -e MYSQL_SERVICE_USER=root -e MYSQL_SERVICE_PASSWORD=123456 -e MYSQL_SERVICE_DB_NAME=nacos -p 8848:8848 --name nacos141 nacos/nacos-server

访问 http://localhost:8848/nacos 用户名/密码：nacos/nacos


docker run -itd --name sentinel-dashboard -p 8858:8858 bladex/sentinel-dashboard:latest
访问 http://localhost:8858 用户名/密码：sentinel/sentinel

 ab -n10 -c2 http://localhost:8082/hi/gx

## ip是docker内的子网ip
redis-cli --cluster create 172.17.0.7:6381 172.17.0.3:6382 172.17.0.6:6383 172.17.0.9:6384 172.17.0.8:6385 172.17.0.5:6386 --cluster-replicas 1

redis-cli --cluster create 172.21.0.7:6381 172.17.0.5:6382 172.17.0.6:6383 172.17.0.4:6384 172.17.0.2:6385 172.17.0.3:6386 --cluster-replicas 1

#在linux把文件传到mysql5.6容器中
#docker cp linux中文件的路径 容器ID:容器内的路径（这里放在容器的/home目录里）
#容器ID用 docker ps 查看
docker cp /home/nacos-mysql.sql f5381aee7490:/home

#进入mysql5.6容器
docker exec -it 容器ID /bin/bash

#进入mysql
mysql -uroot -p123456  --default-character-set=utf8

#创建nacos_config数据库
source /home/nacos-mysql.sql

#退出mysql
exit

#退出容器
exit

#运行nacos
docker run --env MODE=standalone --name nacos -d -p 8848:8848 nacos/nacos-server

#进入nacos1.3容器
docker exec -it 容器ID /bin/bash

cd conf
#备份application.properties
cp application.properties application.properties.bk
#修改application.properties文件
vim application.properties
#如果有提示，按Enter回车进入

docker run -d  --name redis-manager -p 8182:8182 --network bridge -e DATASOURCE_DATABASE='redis_manager' -e DATASOURCE_URL='jdbc:mysql://172.17.0.2:3306/redis_manager?useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2b8' -e DATASOURCE_USERNAME='root' -e DATASOURCE_PASSWORD='123456' reasonduan/redis-manager

访问http://127.0.0.1:8182   用户名/密码 admin/admin

https://blog.csdn.net/qq_41566159/article/details/116099458
docker network create --driver bridge --subnet 192.168.1.0/16 --gateway 192.168.1.0 mynet
docker network inspect mynet
docker network rm mynet



docker run --name elasticsearch721 -p 9200:9200 -p 9300:9300
-e "discovery.type=single-node"
-v D:\study\doc\docker\elasticsearch\config\elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
## es

docker run --name elasticsearch721 -p 9200:9200 -p 9300:9300 \
-e "discovery.type=single-node" \
-v /Users/bluesgao/docker/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/bluesgao/docker/elasticsearch/data:/usr/share/elasticsearch/data \
-v /Users/bluesgao/docker/elasticsearch/plugins:/usr/share/elasticsearch/plugins \
-d elasticsearch:7.2.1


docker run -d --name=kibana721   -p 5601:5601
-v D:\study\doc\docker\kibana\config\kibana.yml:/usr/share/kibana/config/kibana.yml
kibana:7.2.1

docker-compose up -d  // 后台启动并运行容器

## redis
#### win
docker run -p 6379:6379
-v D:\study\doc\docker\redis\config\redis.conf:/etc/redis/redis.conf
-v D:\study\doc\docker\redis\data:/data --name redis -d redis:5.0.12 redis-server /etc/redis/redis.conf

#### mac
docker run -p 6379:6379 --name redis  \
-v /Users/bluesgao/docker/redis/config/redis.conf:/etc/redis/redis.conf \
-v /Users/bluesgao/docker/redis/data:/data \
-v /Users/bluesgao/docker/redis/script:/script \
-d redis:5.0.12 redis-server /etc/redis/redis.conf

#### redis ldb
redis-cli -a 123456 --ldb-sync-mode --eval ./script/demo.lua 2 key1 key2 first second
#### redis ip
docker inspect redis | grep IPAddress

## ETCD
docker run -d --name etcd-server
--publish 2379:2379
--publish 2380:2380
--env ALLOW_NONE_AUTHENTICATION=yes
--env ETCD_ADVERTISE_CLIENT_URLS=http://etcd-server:2379 bitnami/etcd:latest

## minio
docker run -p 9000:9000 --name minio \
-e "MINIO_ACCESS_KEY=admin" -e "MINIO_SECRET_KEY=admin123456" \
 -v /Users/bluesgao/docker/minio/data:/var/minio \
 -v /Users/bluesgao/docker/minio/config:/root/.minio \
 -di minio/minio server /var/minio




