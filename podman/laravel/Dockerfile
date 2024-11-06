FROM dunglas/frankenphp:1-php8.3.13

# Tentukan direktori kerja di /app
WORKDIR /app
# Copy aplikasi Anda ke /app/public
COPY . .

# add additional extensions here:
RUN install-php-extensions \
    zip \
    pgsql \
    pdo_pgsql \
    gmp \
    sockets \
    gd \
    pcntl


# Download dan install Composer sebagai executable
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# Jalankan Composer untuk menginstal dependensi
RUN composer install --no-dev --optimize-autoloader

RUN composer require laravel/octane
RUN php artisan octane:install --server=frankenphp
# Clear dan cache konfigurasi Laravel untuk optimasi
RUN php artisan route:clear && \
    php artisan config:clear && \
    php artisan cache:clear && \
    php artisan config:cache && \
    php artisan route:cache

# Set entrypoint untuk menjalankan Octane dengan server FrankenPHP
ENTRYPOINT ["php", "artisan", "octane:start", "--server=frankenphp", "--host=0.0.0.0", "--port=8000", "--rpc-port=6001","--workers=16"]