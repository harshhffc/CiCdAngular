# Stage 1: Build Angular application
FROM node:18.19.0 as build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve Angular application using nginx
FROM nginx:1.21-alpine


# Copy built Angular app from Stage 1 to Nginx public directory
COPY --from=build /app/dist/ci-cd-test/browser /usr/share/nginx/html

# Copy custom Nginx configuration file if needed (optional)
# COPY nginx-custom.conf /etc/nginx/conf.d/reverse_proxy.conf

# Expose port 4200 (the port your Angular app will be served on)
EXPOSE 4200

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
