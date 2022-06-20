FROM php:8-apache
ARG SSH_PASS=password
ARG SSH_USER=login

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev \
    libfreetype6 \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl 

# Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl mysqli gd

#Install ssh
RUN apt-get -y install --fix-missing openssh-server

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#Add user
RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $SSH_PASS) $SSH_USER
RUN usermod -g $SSH_USER $SSH_USER
RUN usermod -aG sudo $SSH_USER
RUN chown -R $SSH_USER.$SSH_USER /var/www

#Apache configure
RUN a2enmod rewrite

ENTRYPOINT chmod 777 /root/start.sh && /root/start.sh