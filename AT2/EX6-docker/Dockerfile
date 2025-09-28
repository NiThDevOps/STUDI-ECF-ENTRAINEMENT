FROM composer:2 AS deps
WORKDIR /app
COPY app/composer.json ./
RUN composer install --no-dev --no-interaction --no-plugins --no-scripts

FROM php:8.3-apache
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install opcache
WORKDIR /var/www/html
COPY app/ ./
COPY --from=deps /app/vendor ./vendor
RUN mkdir -p storage && chown -R www-data:www-data storage
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD curl -fsS http://localhost/version.php >/dev/null || exit 1
EXPOSE 80
