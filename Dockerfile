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
COPY --from=builder /app/build /usr/share/nginx/html




