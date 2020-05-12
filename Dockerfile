# Build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
# EXPOSE will do nothing in the local env, so I still need to manually 
# the PORT MAPPING. However when this command will be read in Elastic 
# Beanstalk, it will be able to perfom automatically the PORT MAPPING
EXPOSE 80
COPY  --from=builder /app/build /usr/share/nginx/html
# the nginx start-up command is already set in the base image used
