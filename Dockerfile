FROM fedora:latest
MAINTAINER ourfor@foxmail.com
ENV UPDATE_DATE 2019-03-14
RUN dnf -y install systemd systemd-libs
#RUN dnf -y update
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
RUN dnf -y install mariadb-server mariadb;systemctl enable mariadb.service;
RUN dnf install -y net-tools openssh-server openssh-clients passwd;
RUN dnf install -y wget git vim;
RUN curl -fsSL https://raw.github.com/ourfor/Configuration/master/zsh/install.sh;
RUN dnf clean all

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 8080
CMD ["/usr/sbin/init"]

CMD ["/usr/bin/init"]
