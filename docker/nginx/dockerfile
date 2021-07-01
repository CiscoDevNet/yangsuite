FROM nginx
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx
COPY uwsgi_params /etc/nginx
RUN mkdir -p /var/log/nginx
# HTTPS config
RUN mkdir -p /etc/nginx/snippets
COPY ssl-params.conf /etc/nginx/snippets
COPY ssl-signed.conf /etc/nginx/snippets
RUN mkdir -p /etc/nginx/certs
COPY nginx-self-signed.cert /etc/nginx/certs/
COPY nginx-self-signed.key /etc/nginx/certs/
COPY dhparam.pem /etc/nginx/certs/
