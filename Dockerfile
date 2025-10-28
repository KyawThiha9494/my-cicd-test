FROM node:20-alpine AS build
WORKDIR /app
RUN apk add --no-cache bash git python3 make g++
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build:ssr  # build for SSR
EXPOSE 4200
CMD ["node", "dist/my-cicd-test/server/main.js"]
