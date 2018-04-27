FROM nginx:1.13.12-alpine
COPY nginx.conf /etc/nginx/nginx.conf
#COPY data /usr/share/nginx/html
EXPOSE 8080
