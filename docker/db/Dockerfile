FROM percona:ps-8.0.19-10

# Update bash profile
COPY ./docker/.profile /root/.profile
COPY ./docker/.profile /root/.bashrc
COPY ./docker/db/sqlmode.cnf /etc/percona-server.conf.d/sqlmode.cnf
