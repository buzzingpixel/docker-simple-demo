FROM nginx:1.17.9

# Update bash profile
COPY ./docker/.profile /root/.profile
COPY ./docker/.profile /root/.bashrc

# Copy dev configuration into container
COPY ./docker/web/nginx-local.conf /etc/nginx/conf.d/local.conf
COPY ./docker/web/dhparam.pem /etc/nginx/ssl/dhparam.pem
