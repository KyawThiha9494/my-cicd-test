# Dockerfile for Angular
FROM node:20-alpine AS build

WORKDIR /app

# Install Angular CLI
RUN npm install -g @angular/cli

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy all source files
COPY . .

# Build Angular in production
RUN npm run build -- --configuration production

# Serve built app with nginx
FROM nginx:alpine
COPY --from=build /app/dist/my-cicd-test/. /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]