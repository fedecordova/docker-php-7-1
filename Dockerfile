FROM ubuntu:16.04
MAINTAINER Daniel Samson <daniel.samson@salesagility.com>

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Update sources
RUN apt-get update -y

RUN apt-get install -y apache2 curl

ADD ondrej-ubuntu-php-xenial.list /etc/apt/sources.list.d/

RUN apt-get update -y



# install http
RUN apt-get install -y apache2 vim bash-completion unzip
RUN mkdir -p /var/lock/apache2 /var/run/apache2
RUN a2enmod rewrite
RUN rm -f /var/www/html/index.html

# install mysql
RUN echo 'mysql-server mysql-server/root_password password changeme' | debconf-set-selections
RUN echo 'mysql-server mysql-server/root_password_again password changeme' | debconf-set-selections
RUN apt-get install -y mysql-client mysql-server

# install php
RUN apt-get install -y --allow-unauthenticated apache2-mod-php7.1 php7.1 php7.1-bcmath php7.1-bz2 php7.1-cgi php7.1-cli php7.1-common php7.1-curl php7.1-dba php7.1-dev php7.1-enchant php7.1-fpm php7.1-gd php7.1-gmp php7.1-imap php7.1-interbase php7.1-intl php7.1-json php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-odbc php7.1-opcache php7.1-pgsql php7.1-phpdbg php7.1-pspell php7.1-readline php7.1-recode php7.1-snmp php7.1-soap php7.1-sqlite3 php7.1-sybase php7.1-tidy php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip php-xdebug
ADD 30-xdebug-custom.ini /etc/php/7.1/apache2/conf.d/
ADD 30-xdebug-custom.ini /etc/php/7.1/cli/conf.d/

# install git
RUN apt-get --yes --force-yes install git

RUN apt-get --yes --force-yes apt-get install net-tools

# install supervisord
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

#ADD phpinfo.php /var/www/html/

EXPOSE 80 443

CMD ["supervisord", "-n"]