# Stage 1: Build Angular application
FROM node:14 as build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve Angular application using nginx
FROM nginx:1.21-alpine

COPY --from=build /app/dist/CiCdTest /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
