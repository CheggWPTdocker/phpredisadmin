FROM composer/composer:master-alpine
MAINTAINER jgilley@chegg.com

# add curl so we can download the package
RUN	apk --update --no-cache add curl && \
	rm -rf /var/cache/apk/*

# download phpRedisAdmin 1.6.0 from github
# make the running dir
# untar that stuff
# move it to the working dir
RUN curl -o /tmp/source.tgz https://codeload.github.com/erikdubbelboer/phpRedisAdmin/tar.gz/v1.6.0 && \
	mkdir -p /src && \
	tar -zxvf /tmp/source.tgz -C /tmp && \
	mv /tmp/phpRedisAdmin-1.6.0 /src/app

# copy our environment config to source
COPY env_config.php /src/app/includes/config.inc.php

# set the working directory
WORKDIR /src/app

# run composer
RUN composer install 

# expose the port
EXPOSE 80

# start php
ENTRYPOINT ["php","-S","0.0.0.0:80"]
