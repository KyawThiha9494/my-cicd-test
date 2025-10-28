# Stage 1: Build Angular SSR
FROM node:20-alpine AS build

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache bash git python3 make g++

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Build SSR bundles
RUN npm run build:ssr

# Stage 2: Serve SSR app
FROM node:20-alpine

WORKDIR /app

# Copy built SSR bundles from build stage
COPY --from=build /app/dist/my-cicd-test /app/dist/my-cicd-test

# Expose SSR port
EXPOSE 4000

# Start SSR server
CMD ["node", "dist/my-cicd-test/server/main.js"]
