FROM nginx:latest
COPY static-html /usr/share/nginx/html
COPY keys/bsk830.mimuw.edu.pl.crt keys/bsk830.mimuw.edu.pl.key /etc/nginx/ssl/
COPY bsk830.mimuw.edu.pl.conf /etc/nginx/conf.d/
