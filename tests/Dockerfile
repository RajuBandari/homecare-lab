FROM node:10-alpine

WORKDIR /usr/src/app

COPY package*.json /

RUN npm update && \
    npm install -g mocha

COPY . .

# Override the command, to run the test instead of the application
CMD ["mocha", "*/*.test.js", "--recursive", "spec"]