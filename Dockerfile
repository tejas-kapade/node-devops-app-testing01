# Base Image
FROM node:18-alpine

# Create working directory inside container
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy remaining source code
COPY . .

# Expose application port
EXPOSE 3000

# Start application
CMD ["npm","start"]