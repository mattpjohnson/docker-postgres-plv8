#
# Postgres + Plv8 Dockerfile
#
# https://github.com/mattpjohnson/docker-postgres-plv8
#

# Pull base image.
FROM mattpjohnson/postgres:9.5rc1

MAINTAINER Matt Johnson <hello@mattpjohnson.com>

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' 9.5 > /etc/apt/sources.list.d/pgdg.list

RUN echo 'deb http://ftp.debian.org/debian testing main' > /etc/apt/sources.list
RUN echo 'deb http://ftp.debian.org/debian/ jessie-updates main' >> /etc/apt/sources.list
RUN echo 'deb http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# Install Plv8
RUN apt-get update
RUN apt-get install --fix-missing -y \
					build-essential \
					curl \
					libv8-dev \
					postgresql-server-dev-9.5
RUN curl https://bootstrap.pypa.io/ez_setup.py -o - | python
RUN easy_install pgxnclient
RUN pgxn install plv8
