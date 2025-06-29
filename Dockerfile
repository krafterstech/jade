FROM ghcr.io/devopsprabin/php:8.3-ecommerce

ARG _ENV
WORKDIR /app
RUN composer install; exit 0
COPY . .
RUN ls -lah
RUN echo $_ENV

RUN composer update
RUN php artisan storage:link
EXPOSE 8181
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8181"]

RUN php artisan cache:clear
RUN php artisan config:clear
RUN npm install
RUN npm run build
