FROM node:15.12.0-alpine3.13 as builder
WORKDIR /usr/src/app
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/imolorhe/altair.git /usr/src/app
RUN cd packages/altair-app/ && yarn && yarn build

FROM nginx:stable-alpine
COPY --from=builder /usr/src/app/packages/altair-app/dist /usr/share/nginx/html
COPY nginx-altair.conf.template /etc/nginx/templates/
RUN rm /etc/nginx/conf.d/default.conf
