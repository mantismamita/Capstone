FROM nginx:alpine

# Working Directory
WORKDIR /app

# Copy source code to working directory
COPY /app/. /usr/share/nginx/html

# Expose port 80
EXPOSE 80
