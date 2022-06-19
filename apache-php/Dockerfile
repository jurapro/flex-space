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
RUN docker-php-ext-install pdo_mysql zip exif pcntl mysqli

RUN apt-get -y install --fix-missing openssh-server

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $SSH_PASS) $SSH_USER
RUN usermod -g www-data $SSH_USER && usermod -a -G www-data,root root
CMD chmod 0777 /var/www/docker/start.sh && /var/www/docker/start.sh && apache2-foreground