# Stage 1: Build the Angular application
FROM node:18.19.0 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Angular application
RUN npm run build --prod

# Stage 2: Serve the application with httpd
FROM httpd:2.4

# Copy the built Angular application into the httpd directory
COPY --from=build /app/dist/ci-cd-test /usr/local/apache2/htdocs/

# Expose port 80
EXPOSE 80

# Start the httpd server
CMD ["httpd", "-D", "FOREGROUND"]
