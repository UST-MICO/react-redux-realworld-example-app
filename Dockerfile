FROM node:8.15.0-alpine as builder
WORKDIR /app
COPY /package*.json /app/
RUN npm install
COPY . /app
RUN npm run build

FROM nginx:1.13.12-alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=builder /app/nginx.conf /etc/nginx/
COPY --from=builder /app/docker-entrypoint.sh /
#different file permission on unix and windows
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 80