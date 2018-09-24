FROM node:8.1

RUN apt-get update && apt-get -y upgrade
RUN apt-get install curl apt-transport-https apt-utils

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get update && apt-get -y install yarn && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app
COPY . /opt/app
RUN npm install -g create-react-app
RUN yarn install --production && yarn build

EXPOSE 3000

CMD ["yarn", "prod"]
