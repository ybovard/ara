FROM nginx
MAINTAINER Yves Bovard <ybovard@gmail.com>

COPY supervisor.conf /etc/supervisor/docker.conf
COPY ansible.cfg /var/www/ara/ansible.cfg
COPY ara.nginx /etc/nginx/conf.d/ara.conf
COPY ara.uwsgi /etc/uwsgi/apps-available/ara.ini
COPY wsgi.patch /root/wsgi.patch

ENV ANSIBLE_CONFIG /var/www/ara/ansible.cfg

EXPOSE 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/docker.conf"]

RUN apt-get update && apt-get upgrade -y \
  && apt-get -y install supervisor \
  && apt-get -y install gcc python-dev libffi-dev libssl-dev \
  && apt-get -y install python-pip libxml2-dev libxslt1-dev \
  && pip install ansible==2.3.2.0 tox uwsgi ara pymysql \
  && cp /usr/local/bin/ara-wsgi /var/www/ara/wsgi.py \
  && cd /usr/local/lib/python2.7/dist-packages/ara \
  && patch -p0 < /root/wsgi.patch \
  && chown -R nginx:nginx /var/www/ara \
  && mkdir /var/log/uwsgi \
  && chmod 777 /var/log/uwsgi
