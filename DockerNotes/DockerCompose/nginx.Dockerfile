FROM nginx:stable-alpine

COPY ./NginxConfiguration/nginx.conf etc/nginx/conf.d/default.conf