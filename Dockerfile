# BUILD PHASE
FROM node:alpine
# we can tag by using "as 'name_for_tag' ", above we are creating unnamed builder
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# Now the required "build" file will be store in "/app/build" of container

# RUN PHASE
FROM nginx
# EXPOSING FOR ELASTICBEANSTALK, bcz it see EXPOSE port and map it with the elastic bean stalk port automatically, PORT 80 is default port for the nginx
EXPOSE 80
# here we are wrinting 0, bcz we have unnabed builder above, else we will put our 'builder name'
# COPY --from='builder_name' BUILD_FILE_DIRECTORY_ADD HTML_FILE_ADD :: for static website
COPY --from=0 /app/build /usr/share/nginx/html

# execute: docker build .
# execute: docker run -p 'outsystem_port:8080':'nginx_default_port:80' IMAGE_ID