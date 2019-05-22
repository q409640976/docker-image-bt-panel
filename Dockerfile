FROM centos:7

MAINTAINER IT小强xqitw.cn <mail@xqitw.cn>

RUN yum update -y \
    && yum install -y crontabs \
    && yum install -y wget \
    && wget -O install.sh http://download.bt.cn/install/install_6.0.sh

RUN yes | /bin/bash install.sh

RUN echo "#!/bin/sh" >> /www/run.sh \
    && echo "/usr/sbin/crond start" >> /www/run.sh \
    && echo "/etc/init.d/bt start" >> /www/run.sh

LABEL org.label-schema.schema-version="1.0.0" \
    org.label-schema.name="Docker Bt Panel" \
    org.label-schema.vendor="IT小强xqitw.cn" \
    org.label-schema.license="Apache Licence 2.0" \
    org.label-schema.build-date="20190521"

EXPOSE 8888 8080 3306 888 443 80 21 20

VOLUME ["/www/wwwroot","/www/wwwlogs","/www/backup","/www/server/data","/www/server/cron"]

ENTRYPOINT /bin/bash /www/run.sh

CMD ["/bin/bash"]

