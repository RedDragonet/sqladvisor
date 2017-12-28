# 美团SQLAdvior
SQLAdvisor是由美团点评公司技术工程部DBA团队（北京）开发维护的一个分析SQL给出索引优化建议的工具。它基于MySQL原生态词法解析，结合分析SQL中的where条件、聚合条件、多表Join关系 给出索引优化建议。目前SQLAdvisor在美团点评内部广泛应用，公司内部对SQLAdvisor的开发全面转到github上，开源和内部使用保持一致。

# 使用
## --help输出

```
docker run --rm imred/sqladvisor --help 
```

```
Usage:
  sqladvisor [OPTION...] sqladvisor

SQL Advisor Summary

Help Options:
  -?, --help              Show help options

Application Options:
  -f, --defaults-file     sqls file
  -u, --username          username
  -p, --password          password
  -P, --port              port
  -h, --host              host
  -d, --dbname            database name
  -q, --sqls              sqls
  -v, --verbose           1:output logs 0:output nothing
```
## 命令行传参

```
docker run --rm imred/sqladvisor -h xx  -P xx  -u xx -p 'xx' -d xx -q "sql" -v 1
```
## 配置文件传参调用

```
$> cat sql.cnf
[sqladvisor]
username=xx
password=xx
host=xx
port=xx
dbname=xx
sqls=sql1;sql2;sql3....

其中sql.cnf文件的位置需要从本地映射
-v $PWD:/data  代表的是当前目录映射到docker的/data目录 
docker run --rm -v $PWD:/data  imred/sqladvisor -f /data/sql.cnf  -v 1
```




