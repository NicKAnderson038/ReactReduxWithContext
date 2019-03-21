# ReactReduxVsContext

## Building Docker steps

1. Building an application with create-react-app.
2. Run the 'yarn' or 'npm install' commands.

```bash
# Remove node_modules
rm -fr node_modules

# create 2 new files in the root dir 'Dockerfile' & 'run.sh'

# Build docker image
docker image build -t react-16:app .

# Looking inside docker image (not necessary)
docker container run -it react-16:app bash

# Running container 
    # 1. without warm-reloading
docker container run -it -p 3000:3000 react-16:app

    # 2. with Warm-reloading!!! recommended for local development
docker container run -it -p 3000:3000 -p 35729:35729 -v $(pwd):/app react-16:app

# Build directories for deployment
docker container run -it -v $(pwd):/app react-16:app build

# Running Tests
docker container run -it -v $(pwd):/app react-16:app test
# ||
docker container run -it -v $(pwd):/app react-16:app test --coverage
# ||
docker container run -it -v $(pwd):/app react-16:app test --help

# view all docker images
docker ps -a -f status=exited

```
<br>

Create file called: Dockerfile
```Dockerfile
FROM node:10

ADD yarn.lock /yarn.lock
ADD package.json /package.json

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin
RUN yarn

# replace MY-APP with your app name
WORKDIR /MY-APP
ADD . /MY-APP

EXPOSE 3000
EXPOSE 35729

ENTRYPOINT ["/bin/bash", "/MY-APP/run.sh"]

CMD ["start"]
```

<br>

Create file called: run.sh
```bash
#!/usr/bin/env bash
set -eo pipefail

case $1 in
  start)
    # The '| cat' is to trick Node that this is an non-TTY terminal
    # then react-scripts won't clear the console.
    yarn start | cat
    ;;
  build)
    yarn build
    ;;
  test)
    yarn test $@
    ;;
  *)
    exec "$@"
    ;;
esac
```

#

<br>

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.<br>
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br>
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.<br>
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.<br>
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.<br>
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can’t go back!**

If you aren’t satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (Webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you’re on your own.

You don’t have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn’t feel obligated to use this feature. However we understand that this tool wouldn’t be useful if you couldn’t customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: https://facebook.github.io/create-react-app/docs/code-splitting

### Analyzing the Bundle Size

This section has moved here: https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size

### Making a Progressive Web App

This section has moved here: https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app

### Advanced Configuration

This section has moved here: https://facebook.github.io/create-react-app/docs/advanced-configuration

### Deployment

This section has moved here: https://facebook.github.io/create-react-app/docs/deployment

### `npm run build` fails to minify

This section has moved here: https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify
