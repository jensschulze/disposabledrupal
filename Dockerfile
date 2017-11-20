FROM alpine:3.6

RUN apk update --no-cache && \
    apk add --no-cache tzdata git vim curl && rm -f /etc/localtime && mv /usr/share/zoneinfo/Europe/Berlin /etc/localtime && apk del tzdata

RUN echo '@community https://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo '@edgemain https://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add libressl@edgemain \
        openssl@edgemain \
        sqlite@edgemain \
        php7 \
        php7-apcu \
        php7-dev \
        php7-bcmath \
        php7-bz2 \
        php7-calendar \
        php7-common \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-exif \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-imagick \
        php7-imap \
        php7-json \
        php7-ldap \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqli \
        php7-mysqlnd \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-pear \
        php7-phar \
        php7-posix \
        php7-session \
        php7-simplexml \
        php7-soap \
        php7-sockets \
        php7-sqlite3 \
        php7-tokenizer \
        php7-xml \
        php7-xmlwriter \
        php7-xsl \
        php7-zlib \
        php7-zip && \
    rm -rf /var/cache/apk/*

RUN ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm && \
    ln -sf /usr/bin/php7 /usr/bin/php

COPY ./php7/php.ini /etc/php7/conf.d/zzzz-custom.ini
