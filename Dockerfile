FROM fedora:latest
MAINTAINER ourfor@qq.com
ENV UPDATE_DATE 2019-11-13
RUN dnf -y install systemd systemd-libs
RUN dnf clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; \
do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN dnf install -y tomcat tomcat-webapps tomcat-admin-webapps;
RUN sed -i 's/\/usr\/lib\/jvm\/jre/\/usr\/java\/jdk1.8.0_231-amd64/' /usr/share/tomcat/conf/tomcat.conf
RUN curl --output /tmp/jdk-8u231-linux-x64.rpm http://cdn.ourfor.top/jdk-8u231-linux-x64.rpm
RUN rpm -ivh /tmp/jdk-8u231-linux-x64.rpm
RUN ls /usr/java
RUN systemctl enable tomcat
RUN dnf clean all

EXPOSE 8080
EXPOSE 8009
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
