FROM ubuntu:bionic

LABEL maintainer="miguel@digitec.ws"

ENV TERM=linux
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install -y --no-install-recommends software-properties-common gnupg

RUN add-apt-repository ppa:ondrej/php

RUN apt-get -y update

RUN apt-get -y --no-install-recommends install \
        ca-certificates \
        git \
        curl \
        unzip \
        php-apcu \
        php-apcu-bc \
        php7.4-cli \
        php7.4-curl \
        php7.4-json \
        php7.4-mbstring \
        php7.4-opcache \
        php7.4-readline \
        php7.4-xml \
        php7.4-zip
        
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo \
    && composer clear-cache
    
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* ~/.composer
    
CMD ["php", "-a"]