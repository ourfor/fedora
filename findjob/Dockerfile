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
ADD $PWD/mongodb-org.repo /etc/yum.repos.d/mongodb-org-4.2.repo
RUN dnf install -y httpd tomcat mongodb-org;
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
RUN mkdir -p /opt/app/findjob
ADD $PWD/deploy/db /opt/app/findjob/db
ADD $PWD/deploy/dist /var/www/findjob
ADD $PWD/deploy/job.war /opt/app/findjob/job.war
ADD $PWD/findjob.conf /etc/httpd/conf.d/findjob.conf
ADD $PWD/init.service /usr/lib/systemd/system/init.service
ADD $PWD/setup.sh /opt/app/findjob/setup.sh
RUN systemctl enable tomcat;
RUN systemctl enable httpd;
RUN systemctl enable mongod;
RUN systemctl enable init;
RUN dnf clean all

VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 80
CMD ["/usr/sbin/init"]
