FROM jensschulze/php7:latest

COPY ./composerinstall.php /root/

ARG branch=develop

RUN mkdir -p /tmp/opcache /var/www && rm -rf /var/www/* && cd /root && php ./composerinstall.php && \
    php /root/composer.phar global require hirak/prestissimo jderusse/composer-warmup && \
    cd /var/www && php /root/composer.phar create-project jensschulze/drupal-project:${branch}-dev disposabledrupal --stability dev --no-interaction && \
    cd /var/www/disposabledrupal && php /root/composer.phar warmup-opcode && \
    rm -rf /root/.composer

ARG installprofile=basicdrupal

RUN  cd /var/www/disposabledrupal/web && \
    ../bin/drush si -y --db-url=sqlite://sites/default/files/.ht.sqlite --account-name=admin --account-pass=admin --site-name="Disposable Drupal" ${installprofile} install_configure_form.enable_update_status_module=NULL install_configure_form.enable_update_status_emails=NULL

RUN cd /var/www/disposabledrupal/web && \
        ../bin/drush cex -y

WORKDIR /var/www/disposabledrupal/web

EXPOSE 8888

CMD ["../bin/drush", "rs", "0.0.0.0:8888"]
