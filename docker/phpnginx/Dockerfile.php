FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pgsql pdo_pgsql pdo_mysql exif pcntl bcmath gd intl xmlrpc soap

# Get latest Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

