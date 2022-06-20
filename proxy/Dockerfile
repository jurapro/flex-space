FROM nginx:1.19.6-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf

ARG SERVER_NAME
ARG WEB_PORT
RUN sed -i 's#{{ SERVER_NAME }}#'$SERVER_NAME'#g' /etc/nginx/conf.d/default.conf
RUN sed -i 's#{{ WEB_PORT }}#'$WEB_PORT'#g' /etc/nginx/conf.d/default.conf