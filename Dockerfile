FROM ubuntu:bionic-20210416

# Install depencies.
RUN apt update -y && \
    apt install -y \
        make \
        gcc \
        curl \
        gnupg \
        ruby-full

# Install gems.
RUN gem install \
        rack \
        sorbet \
        sorbet-runtime \
        mongo

# Install MongoDB.
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | \
    apt-key add -

RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | \
    tee /etc/apt/sources.list.d/mongodb-org-4.4.list

RUN apt update -y && \
    DEBIAN_FRONTEND="noninteractive" \
    apt install -y \
        mongodb-org

# Create a directory where Mongo can store data.
# https://stackoverflow.com/questions/41420466/mongodb-shuts-down-with-code-100
RUN mkdir -p /data/db

COPY . /app


WORKDIR /app

CMD ["/app/start.sh"]
