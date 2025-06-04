FROM php:8.1-apache

# Install PDO extensions
RUN docker-php-ext-install pdo pdo_mysql

# Set proper permissions and copy app
COPY . /var/www/html

# Set Apache config to allow access
RUN echo '<Directory "/var/www/html">' > /etc/apache2/conf-enabled/allow-override.conf && \
    echo '    AllowOverride All' >> /etc/apache2/conf-enabled/allow-override.conf && \
    echo '    Require all granted' >> /etc/apache2/conf-enabled/allow-override.conf && \
    echo '</Directory>' >> /etc/apache2/conf-enabled/allow-override.conf

# Set ownership to www-data (Apache user)
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Optional: Enable Apache rewrite module (required by Yii2)
RUN a2enmod rewrite

# Expose Apache
EXPOSE 80
