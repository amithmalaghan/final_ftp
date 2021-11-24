from centos:7

ARG NET2FTP_V=1.3
ENV DB_NAME=''
ENV DB_IP=''
ENV DB_USER=''
ENV DB_PASSWD=''
RUN yum install -y epel-release
RUN yum install -y httpd
RUN yum install -y php
#RUN yum install -y phpmyadmin
RUN yum install -y wget unzip
RUN wget https://www.net2ftp.com/download/net2ftp_v${NET2FTP_V}.zip
RUN unzip net2ftp_v${NET2FTP_V}.zip
RUN mkdir /var/www/html/ftp
RUN mv net2ftp_v${NET2FTP_V}/files_to_upload/* /var/www/html/ftp
RUN chmod 777 /var/www/html/ftp/temp
RUN yum install -y proftpd-mysql
RUN yum install -y openssl
#RUN sed -i -e '17d' -e '18d' /etc/httpd/conf.d/phpMyAdmin.conf
#RUN sed -i '16 a Require all granted' /etc/httpd/conf.d//phpMyAdmin.conf
#RUN sed -i "s/\$cfg\['Servers'\]\[\$i\]\['host'\]          = 'localhost'/\$cfg\['Servers'\]\[\$i\]\['host'\]      = '172.17.0.3'/" etc/phpMyAdmin/config.inc.php
#RUN sed -i "s/\$cfg\['Servers'\]\[\$i\]\['port'\]          = ''/\$cfg\['Servers'\]\[\$i\]\['port'\]          = ''/" etc/phpMyAdmin/config.inc.php
#RUN sed -i "s/\$cfg\['Servers'\]\[\$i\]\['user'\]          = ''/\$cfg\['Servers'\]\[\$i\]\['user'\]          = 'root'/" etc/phpMyAdmin/config.inc.php
#RUN sed -i "s/\$cfg\['Servers'\]\[\$i\]\['password'\]      = ''/\$cfg\['Servers'\]\[\$i\]\['password'\]      = 'pass'/" etc/phpMyAdmin/config.inc.php
COPY sql.conf /etc/
RUN  rm /etc/proftpd.conf
COPY proftpd.conf /etc/
ADD entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh
#RUN chmod 755 /etc/sql.conf


RUN adduser ftpuser
RUN yum install -y sudo
RUN echo "ftpuser ALL= NOPASSWD : /usr/sbin/httpd, /usr/sbin/proftpd, /usr/sbin/entrypoint.sh" >> /etc/sudoers

RUN chown ftpuser:ftpuser /etc/sql.conf

#RUN chmod 755 /etc/sql.conf
#RUN ./usr/sbin/entrypoint.sh
ENTRYPOINT [ "/usr/sbin/entrypoint.sh" ]
USER ftpuser
CMD sudo /usr/sbin/httpd  && sudo proftpd --nodaemon
expose 80
