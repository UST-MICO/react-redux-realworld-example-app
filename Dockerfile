FROM node:8.15.0-alpine as builder
WORKDIR /app
COPY /package*.json /app/
RUN npm install
COPY . /app
RUN npm run build

FROM nginx:1.13.12-alpine
COPY --from=builder /app/build /usr/share/nginx/html
ENTRYPOINT ["nginx","-g","daemon off;"]
EXPOSE 80