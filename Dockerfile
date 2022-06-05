FROM node:16

ENV NODE_ENV=production

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# Bundle app source
COPY . .

RUN npm install --include=dev
RUN npm run demo:ui:build

EXPOSE 3000
EXPOSE 8080

CMD [ "bash", "run-demo.sh" ]
