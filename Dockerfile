# Use the node image and 16-alpine tag.
# Beyond that, we create a phase name called builder
FROM node:16-alpine as builder 
WORKDIR '/app'
# Copy only one file
COPY package.json .
# Install the dependencies
RUN npm install
# Copy my source code
COPY . . 
RUN npm run build

FROM nginx 
# Expose doesn't replace -p 80:80 in our local machine. However, AWS Elastic Beanstalk use it to expose the port
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html




