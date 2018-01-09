server
{
  server_name ${siteExternalUrl};
  return 301 $scheme://www.${siteExternalUrl}$request_uri;
}

server
{
  listen 80;
  listen [::]:80;
  index index.php index.html;
  server_name www.${siteExternalUrl} ${siteInternalUrl};
  error_log /var/log/nginx/error.log;
  access_log /var/log/nginx/access.log;
  root /app/docroot;
  sendfile off;
  client_max_body_size 20M;

  location = /favicon.ico
  {
    log_not_found off;
    access_log off;
  }

  location = /robots.txt
  {
    allow all;
    log_not_found off;
    access_log off;
  }

  location ~ \..*/.*\.php$
  {
    return 403;
  }

  location ~ ^/sites/.*/private/
  {
    return 403;
  }

  location ~* ^/.well-known/
  {
    allow all;
  }

  location ~ (^|/)\.
  {
    return 403;
  }

  location @drupal
  {
    rewrite ^/(.*)$ /index.php?q=$1 last;
  }

  location /
  {
    try_files $uri @drupal;
  }

  location ~ /vendor/.*\.php$
  {
    deny all;
    return 404;
  }

  location ~ \.php$
  {
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass php:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;
    fastcgi_param REMOTE_ADDR $http_x_real_ip;
    fastcgi_buffers 16 16k;
    fastcgi_buffer_size 32k;
    include fastcgi_params;
    fastcgi_read_timeout 3600;
    fastcgi_send_timeout 300;
    fastcgi_connect_timeout 300;
    fastcgi_cache off;
    fastcgi_intercept_errors on;
    fastcgi_hide_header \'X-Drupal-Cache\';
    fastcgi_hide_header \'X-Generator\';
  }

  location @rewrite
  {
    rewrite ^/(.*)$ /index.php?q=$1;
  }

  location ~ ^/sites/.*/files/styles/
  {
    # For Drupal >= 7
    try_files $uri @rewrite;
  }

  location ~* \.(js|css|png|jpg|jpeg|gif|ico)$
  {
    expires max;
    log_not_found off;
  }

  location ~* \.(eot|otf|ttf|woff|woff2)$
  {
    add_header Access-Control-Allow-Origin *;
  }

  location = /health_check
  {
    return 200 'OK';
    access_log off;
  }

  location /nginx_status
  {
    stub_status on;
    access_log   off;
    allow localhost;
    deny all;
  }
}
