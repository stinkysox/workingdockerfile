# Use node:20-alpine
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies as root
RUN npm install

# Create a non-root user and switch
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Copy rest of the code
COPY . .

# Expose Vite dev server port
EXPOSE 5173

# Enable polling for hot reload on Windows
ENV CHOKIDAR_USEPOLLING=true

# Start Vite dev server
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
