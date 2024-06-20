# Stage 1: Build Angular application
FROM node:18.19.0 as build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod || (cat /root/.npm/_logs/*-debug.log && false)

# Stage 2: Serve Angular application using nginx
FROM nginx:1.21-alpine

COPY --from=build /app/dist/ci-cd-test /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
