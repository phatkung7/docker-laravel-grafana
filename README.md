# php-nginx-mysql-laravel-docker
 php8.0 / Nginx / MySQL / Grafana / Prometheus => For Laravel 8 
# Install Laravel Project  
- Clone Project From Github and set folder name "web"
- Create or Copy .env file
# Goto Code web Directory and Run to install composer
- docker run --rm -v $(pwd):/app composer install
# Create Container from docker-compose.yml
- docker-compose up -d
# Dashboard Grafana
- Import Dashboard Node Exporter Full ( id 1860 )
# Other Config
- Nginx /nginx/con.d/app.conf
- Mysql /mysql/my.cnf
- PHP /php/local.ini
- SSL Cert /ssl
- web /web
