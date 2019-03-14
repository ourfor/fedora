FROM ourfor/tomcat
MAINTAINER ourfor.top
RUN dnf install -y wget git vim
RUN curl -fsSL https://raw.github.com/ourfor/Configuration/master/zsh/install.sh
RUN dnf cleanup all


CMD ["/usr/bin/init"]
