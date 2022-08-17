# php-nginx-mysql-laravel-docker
 php8 / Nginx / MySQL  => For Laravel8 

# Install Project  
- Clone Project From Github and set folder name "web"
- Create .env file
# Goto Code web Directory and Run to install composer
docker run --rm -v $(pwd):/app composer install
# Create Container from docker-compose.yml
run docker-compose up -d
