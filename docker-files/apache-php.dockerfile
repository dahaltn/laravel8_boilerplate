FROM php:8.0-apache
LABEL maintainer="dahaltn@gmail.com"

# Copy composer.lock and composer.json
# COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    npm \
    cron \
    nodejs \
    iputils-ping \
    mariadb-client \
    rsyslog \
    openssl \
    openssh-server \
    libxml2-dev

RUN docker-php-ext-install mysqli xml pdo_mysql mbstring exif pcntl bcmath gd pdo

RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

## Add user for web application
#RUN groupadd -g 1000 www
#RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
#COPY . /var/www

## Copy existing application directory permissions
#COPY --chown=www:www . /var/www
#
## Change current user to www
#USER www

# Expose port 9000 and start php-fpm server
#EXPOSE 9000
CMD ["apache2-foreground"]