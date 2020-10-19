# IoDLT Symbol Server Image - Dockerized

This repository contains instructions for generating a custom [catapult-server](https://github.com/nemtech/catapult-server/) docker image to use with the [symbol-bootstrap](https://github.com/nemtech/symbol-bootstrap) tool.  This Dockerfile uses [conan](https://conan.io/) recipes to compile the server image.

This enables for custom forks to be compiled and utilized using `symbol-bootstrap` by overriding the `symbolServerImage` parameter in a preset file:

```yml
symbolServerImage: mydockerioduser/catapult-server:version_number
```

## Building

Build as you would any docker image.  If you wish to compile a different version of `catapult-server`, change the `SERVER_VERSION` variable in the Dockerfile. Keep in mind the version should support conan.

```sh
cd iodlt-symbol-server-docker
docker build -t mytaggedserver .
```
