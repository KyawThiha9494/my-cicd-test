# Stage 1 — Build Angular app
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2 — Serve with nginx
FROM nginx:alpine

COPY --from=build /app/dist/my-cicd-test/browser /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
