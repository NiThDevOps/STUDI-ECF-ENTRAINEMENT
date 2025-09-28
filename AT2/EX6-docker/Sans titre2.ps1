# Dans AT2/EX6-docker
docker build --no-cache -t ex6-php:1.0 .
docker volume create ex6-logs
docker network create ex6-net 2>$null

docker run -d --name ex6-php `
  --cpus=2 --memory=510m `
  --network ex6-net -p 8080:80 `
  -e APP_VERSION=1.0.0 `
  -v ex6-logs:/var/www/html/storage `
  ex6-php:1.0
