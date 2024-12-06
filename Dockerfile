# Use a newer version of Node.js (e.g., Node.js 18)
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Expose the port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"]