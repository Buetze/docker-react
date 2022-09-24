FROM node:16-alpine as builder
# create manually so folder uses node user and not root user
RUN mkdir -p /app
WORKDIR '/app'
COPY --chown=node:node package.json .
RUN npm install
COPY --chown=node:node . .
RUN ["npm", "run", "build"]

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
