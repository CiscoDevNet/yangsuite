FROM nginx
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx
COPY uwsgi_params /etc/nginx
RUN mkdir -p /var/log/nginx
