FROM composer/composer:master-alpine
MAINTAINER jgilley@chegg.com

COPY ./source/ /src/app/
COPY env_config.php /src/app/includes/config.inc.php
WORKDIR /src/app

RUN composer install 

EXPOSE 80

ENTRYPOINT ["php","-S","0.0.0.0:80"]
