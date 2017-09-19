# Description
This image contains Ansible ARA (http://ara.readthedocs.io/en/latest/index.html) web application. The database should be installed out of this container.

# Tags
* nginx
run ARA on NGINX (https://nginx.org/en/). This image is based on the nginx official container:
```
docker run \
  --name ara \
  -v <my_ssl_certificates_dir>/:/etc/nginx/ssl \
  -e "ARA_DATABASE=mysql+pymysql://db_user:db_password@db_host/db_name" \
  ybovard/ara:nginx
```
The directory ```<my_ssl_certificates_dir>``` should contains 2 files: ssl.crt and ssl.key
