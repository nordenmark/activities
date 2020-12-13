# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
FROM node:12-alpine

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# Copying this first prevents re-running npm install on every code change.
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn

# Copy local code to the container image.
COPY . ./

# Build the application
RUN yarn build

# DEBUG
RUN ls -alh

# Run the web service on container startup.
CMD [ "yarn", "start:prod" ]