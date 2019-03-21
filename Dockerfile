# base image
FROM node:10

LABEL NicKAnderson038 <https://github.com/NicKAnderson038>

ADD yarn.lock /yarn.lock
ADD package.json /package.json

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin
# install and cache app dependencies
RUN yarn

WORKDIR /react-redux-vs-context
ADD . /react-redux-vs-context

EXPOSE 3000
EXPOSE 35729

ENTRYPOINT ["/bin/bash", "/react-redux-vs-context/run.sh"]

# start app
CMD ["start"]

# Based on the official Node v8 repository on Docker Hub. Gives you a Node and Yarn by default.
# CMD ["yarn", "start"]