# Stage 1 — Build Angular app
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy project source and (optional) build it
COPY . .
RUN npm run build -- --configuration development

# Stage 2 — Serve with nginx (lightweight & simple)
FROM nginx:alpine

# Copy built Angular files to nginx default folder
COPY --from=build /app/dist/my-cicd-test /usr/share/nginx/html

# Expose default web port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
