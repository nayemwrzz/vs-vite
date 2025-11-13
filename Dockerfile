# Step 1: Use Node.js image to build the app
# Use the current Long-Term Support version of Node.js
FROM node:lts-alpine AS build

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json to install dependencies
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the app files to the container
COPY . .

# Step 6: Build the app for production
RUN npm run build

# Step 7: Use Nginx to serve the production build
FROM nginx:alpine

# Step 8: Copy the build from the previous stage to the Nginx container
COPY --from=build /app/dist /usr/share/nginx/html

# Step 9: Expose the port that Nginx will listen on
EXPOSE 80

# Step 10: Start Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
