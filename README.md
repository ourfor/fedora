# fedora
docker的秒启动真是深得我心，所以打算构建一个用于测试` jsp ` 代码的` fedora `镜像

# 镜像靓点
1. 预装` tomcat `、` git `、` mariadb `、` tomcat `、` ssh `、` zsh `并启用` systemd `
2. 可以用作IDEA内的tomcat远程部署功能
3. 可用于学习linux操作系统

# 使用该镜像

```bash
docker pull ourfor/tomcat
docker run --privileged -d \
-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v $PWD/webapps:/var/lib/tomcat/webapps:rw \
-h docker.server -p 4040:8080 -p 2020:22 \
-p 9906:3306 \
-t ourfor/tomcat
```
