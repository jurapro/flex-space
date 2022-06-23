FROM php:8-apache
ARG SSH_PASS=password
ARG SSH_USER=login
ARG LARAVEL
ARG YII
ARG VUE
ARG REACT
ARG ANGULAR

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


#Add user
RUN useradd -m -s /bin/bash -p $(openssl passwd -1 $SSH_PASS) $SSH_USER
RUN usermod -g $SSH_USER $SSH_USER
RUN usermod -aG sudo $SSH_USER
RUN chown -R $SSH_USER.$SSH_USER /var/www
RUN echo "cd /var/www">>/home/$SSH_USER/.bashrc

#Install Composer
# INSTALL COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

#install Laravel
RUN if [ "${LARAVEL}" = "true" ]; then su - $SSH_USER -c "composer global require laravel/installer" && \
                                ln -s /home/$SSH_USER/.config/composer/vendor/bin/laravel /usr/local/bin/laravel; fi

#install Yii
RUN if [ "${YII}" = "true" ]; then su - $SSH_USER -c "composer create-project --prefer-dist yiisoft/yii2-app-basic basic" && \
                               cp -a -T /home/${SSH_USER}/basic /var/www/basic-yii; fi

#Install node
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && apt-get install -y nodejs

#install Vue
RUN if [ "${VUE}" = "true" ]; then npm install -g @vue/cli; fi

#install React
RUN if [ "${REACT}}" = "true" ]; then npm install -g create-react-app; fi

#install Angular
RUN if [ "${ANGULAR}}" = "true" ]; then npm install -g @angular/cli; fi

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#Apache configure
RUN a2enmod rewrite

ENTRYPOINT chmod 777 /root/start.sh && /root/start.sh