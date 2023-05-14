# pull the latest official nginx image
FROM nginx:stable
# run docker service on HTTPS
EXPOSE 443
# copy the additional nginx configuration
COPY maintanence.conf /etc/nginx/conf.d/maintanence.conf
COPY Web1.html /usr/share/nginx/html/index.html
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]