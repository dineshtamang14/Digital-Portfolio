FROM node:16-alpine as base
WORKDIR /usr/src/app
COPY package.json .
RUN yarn install
COPY . .
RUN yarn run build


FROM nginx:alpine 
WORKDIR /usr/share/nginx/html
COPY --from=base /usr/src/app/build .
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]