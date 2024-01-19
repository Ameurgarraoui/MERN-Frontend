FROM node:18-alpine

# Set the working directory to the root of your project
WORKDIR /usr/app/client
COPY ./ /usr/app
RUN npm install

# Expose the port the application runs on
EXPOSE 3000

# Run the command to start Django's development server
CMD ["npm", "start"]
