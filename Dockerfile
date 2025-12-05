# Use latest node official image 
FROM node:22-slim AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files
COPY . .

# Build the application
RUN npm run build

# Use a lighter version of the node image for running the app
FROM node:22-slim AS runner

# Set the working directory
WORKDIR /app

# Install PM2 globally in the runner stage
RUN npm install -g pm2

# Copy the built files from the builder stage
COPY --from=builder /app/.output /app/.output 

# Expose port 3000
EXPOSE 3000

# Run the built application with PM2
ENTRYPOINT ["pm2-runtime", ".output/server/index.mjs"]
