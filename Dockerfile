FROM alpine:3.6

RUN apk update --no-cache && \
    apk add --no-cache tzdata git vim curl && rm -f /etc/localtime && mv /usr/share/zoneinfo/Europe/Berlin /etc/localtime && apk del tzdata

RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo '@edgemain http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add openssl@edgemain \
        sqlite@edgemain \
        php7@community \
        php7-apcu@community \
        php7-dev@community \
        php7-bcmath@community \
        php7-bz2@community \
        php7-calendar@community \
        php7-common@community \
        php7-ctype@community \
        php7-curl@community \
        php7-dom@community \
        php7-exif@community \
        php7-fpm@community \
        php7-gd@community \
        php7-iconv@community \
        php7-imagick@edgemain \
        php7-imap@community \
        php7-json@community \
        php7-ldap@community \
        php7-mbstring@community \
        php7-mcrypt@community \
        php7-mysqli@community \
        php7-mysqlnd@community \
        php7-opcache@community \
        php7-openssl@community \
        php7-pdo@community \
        php7-pdo_mysql@community \
        php7-pdo_sqlite@community \
        php7-pear@community \
        php7-phar@community \
        php7-posix@community \
        php7-session@community \
        php7-simplexml@community \
        php7-soap@community \
        php7-sockets@community \
        php7-sqlite3@community \
        php7-tokenizer@community \
        php7-xml@community \
        php7-xmlwriter@community \
        php7-xsl@community \
        php7-zlib@community \
        php7-zip@community && \
    rm -rf /var/cache/apk/*

RUN ln -s /usr/sbin/php-fpm7 /usr/sbin/php-fpm && \
    ln -sf /usr/bin/php7 /usr/bin/php

COPY ./php7/php.ini /etc/php7/conf.d/zzzz-custom.ini

COPY ./composerinstall.php /root/

ARG branch=develop

RUN mkdir -p /var/www && rm -rf /var/www/* && cd /root && php ./composerinstall.php && cd /var/www && \
    php /root/composer.phar create-project jensschulze/drupal-project:${branch}-dev disposabledrupal --stability dev --no-interaction && \
    rm -rf /root/.composer

ARG installprofile=standard

RUN  cd /var/www/disposabledrupal/web && \
    ../bin/drush si -y --db-url=sqlite://sites/default/files/.ht.sqlite --account-name=admin --account-pass=admin --site-name="Disposable Drupal" ${installprofile} install_configure_form.enable_update_status_module=NULL install_configure_form.enable_update_status_emails=NULL

RUN cd /var/www/disposabledrupal/web && \
        ../bin/drush cex -y

WORKDIR /var/www/disposabledrupal/web

EXPOSE 8888

CMD ["../bin/drush", "rs", "0.0.0.0:8888"]
