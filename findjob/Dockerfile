FROM fedora:latest
MAINTAINER ourfor@foxmail.com
ENV UPDATE_DATE 2019-10-30
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
RUN dnf install -y tomcat;systemctl enable tomcat.service;
RUN dnf install -y tomcat tomcat-webapps tomcat-admin-webapps;systemctl enable tomcat.service;
RUN dnf install -y gcc wget git vim;
ADD $PWD/mongodb-org-4.2.repo /etc/yum.repos.d/mongodb-org-4.2.repo
RUN dnf install -y mongodb-org;systemctl enable mongod.service;
RUN dnf clean all

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 8080
CMD ["/usr/sbin/init"]
