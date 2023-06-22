###
###  This Docker file processes Multi Stage Build for help-growi-cloud
###

#
#  Build Stage
#
FROM node:16-alpine AS builder

WORKDIR /growi-docs

COPY . .
RUN yarn
RUN yarn help-growi-cloud:build


#
# Production Stage
#
FROM nginx:alpine

COPY --from=builder /growi-docs/docs/.vuepress/dist /usr/share/nginx/html/help
COPY --from=builder /growi-docs/docs/.vuepress/dist/assets/images /usr/share/nginx/html/assets/images
RUN rm -rf /usr/share/nginx/html/help/assets/images

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
