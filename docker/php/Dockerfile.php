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
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

#RUN chown -R www-data:www-data /var/www
#COPY --chown=$user:$user . /var/www/html
	
# Set working directory
WORKDIR /var/www

USER $user
# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]