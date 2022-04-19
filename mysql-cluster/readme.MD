## ################### master 操作 #############################
show databases ;
use test;
show tables;

## 错误日志
show variables like '%log_error%';
## 通用日志
show variables like '%general_log%';
## 否启用慢查询日志
show variables like '%slow_query_log%';
## 指定慢查询超时时长(默认10秒)，超出此时长的属于慢查询
show variables like '%long_query_time%';


## 查看binlog信息
show variables like '%log_bin%';
## 查看当前使用了哪些二进制日志文件
show binary logs;
## 查看日志中进行了哪些操作
show binlog events in 'mysql-bin.000004';
## 指定起始位置
show binlog events in 'mysql-bin.000004' from 1434;

## 查看binlog format
show  variables like '%binlog_format%';

## 查看MYSQL数据库中所有用户
SELECT DISTINCT CONCAT('User: ''',user,'''@''',host,''';') AS query FROM mysql.user;

## 查看数据库中具体某个用户的权限
show grants for 'slave'@'%';
select * from mysql.user where user='slave';

## 创建用户并分配权限
GRANT replication slave ON *.* TO 'slave'@'%' IDENTIFIED BY '123456';

GRANT SELECT, INSERT,UPDATE ON order.* TO 'test'@'%';

GRANT ALL ON *.* TO 'admin'@'%' IDENTIFIED BY 'Gx-123456';

## 刷新权限：
flush privileges;
## 查看master状态
show master status ;

## ################### slave 操作 #############################
## 查看slave状态
show slave status;

stop slave;

## 配置主从复制（如果使用docker，host配置container名称即可，同时确保master和slave在一个子网中）
change master to
  master_host='mysql-master',
  master_port=3306,
  master_user='slave',
  master_password='123456',
  master_log_file='mysql-bin.000003',
  master_log_pos=434;

## 启动复制进程
start slave;

## ###################### 验证 #############################################
## 在master建表，然后在slave建表
CREATE TABLE `t_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '公司名称',
  `description` varchar(256) NOT NULL COMMENT '公司简介',
  `c_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `m_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='公司信息表';
## 在master插入数据
INSERT INTO `test`.`t_company` (`name`, `description`) VALUES ('bluesgao','desc');
## 在slave查看数据是否同步