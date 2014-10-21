FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

RUN apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:root' |chpasswd
RUN sed -i "s/session.*required.*pam_loginuid.so/#session    required     pam_loginuid.so/" /etc/pam.d/sshd
RUN sed -i "s/PermitRootLogin without-password/#PermitRootLogin without-password/" /etc/ssh/sshd_config

# Puppet
RUN apt-get -y install ruby
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install puppet
ADD puppet /tmp/puppet
ADD hiera.yaml /etc/puppet/hiera.yaml
RUN export FACTER_db_username="piwik@localhost"
RUN export FACTER_db_password="secure"
RUN puppet apply --modulepath=/tmp/puppet/modules /tmp/puppet/site.pp

RUN apt-get install -y net-tools telnet nmap
RUN apt-get install -y socat dnsutils netcat inetutils-ping tree htop sudo software-properties-common

ADD www /var/www

ENTRYPOINT ["/bin/bash"]