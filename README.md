## 旨在探索docker环境下的rails开发
开发本地环境要求:安装docker并修改docker镜像源
```
https://get.daocloud.io/boot2docker/osx-installer/
https://jxus37ad.mirror.aliyuncs.com
```

通过Dockerfile构建rails环境,Dockerfile由运维编写
redis采用容器的方式
数据库由于涉及到数据的共享没有在每个compose_project单独起一个postgresql而是采用外部连接的方式

所有的构建镜像操作全部在CI/CD系统,服务器端只进行镜像的拉取更新(通过触发ansible分发)

### 测试

```
docker-compose build
docker-compose run --rm web rails new . --api --force --database=postgresql --skip-bundle
docker-compose run --rm web rake db:migrate
docker-compose up -d --force-recreate  #重新build
```
### 添加别名
```
alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcr="docker-compose run --rm"
```
```
#清理虚悬镜像
docker rmi -f $(docker images -q -f dangling=true)
#清理停止容器
docker rm $(docker ps -a -q)
```

### 问题
redis\postgresql\mysql也是容器部署? 如何做redis\postgresql\mysql的集群?

