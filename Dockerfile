FROM php:8.0-fpm

# Copy composer.lock and composer.json into the working directory
COPY ./web/composer.lock /var/www/html/ 
COPY ./web/composer.json /var/www/html/
# Set working directory
WORKDIR /var/www/html/
# Copy SSL
#COPY ./ssl/DigiCertCA.crt /etc/ssl/certs/DigiCertCA.crt
#COPY ./ssl/wildcard_moph_go_th.crt /etc/ssl/certs/wildcard_moph_go_th.crt
#COPY ./ssl/wildcard_moph_go_th.key /etc/ssl/certs/wildcard_moph_go_th.key
# Install dependencies for the operating system software
# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    locales \
    libzip-dev \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    nano
# Install MSSQL Connect
RUN apt-get -y install unixodbc-dev 
RUN pecl install sqlsrv pdo_sqlsrv
# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions for php
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents to the working directory
COPY . /var/www/html

# Assign permissions of the working directory to the www-data user
RUN useradd -G www-data,root -u 1000 -d /home/administrator administrator
RUN chown -R www-data:www-data \
        /var/www/storage \
        /var/www/bootstrap/cache

# Expose port 9000 and start php-fpm server (for FastCGI Process Manager)
EXPOSE 9000
CMD ["php-fpm"]
