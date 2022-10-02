# rabbitmq-queue-management-docker

This project provides Docker images for the project `https://github.com/gessnerfl/rabbitmq-queue-management`.

The images used to build and run the compiled Java project are:

- `eclipse-temurin:17.0.4.1_1-jdk-focal` as the builder image
- `eclipse-temurin:17.0.4.1_1-jre-focal` as the image to run the compiled project

Hence, the base OS is Ubuntu 20.04.

The OpenJDK base images are now deprecated hence are not being used but eclipse-temurin provide offical Docker hub images using OpenJDK binaries.

The images built using this repo can be found in the Docker Hub repo: `pymichaelb/rabbitmq-queue-management`.

To use, first pull the required image:

```
docker pull pymichaelb/rabbitmq-queue-management:<TAG>
```

Then, make sure a config file (details in the project itself) is mounted on the container and then run:

```
docker run -p <PORT>:8780 pymichaelb/rabbitmq-queue-management:<TAG> -Dspring.config.location=<PATH TO CONFIG FILE>
```

## Releasing
1) Merge all changes to master create a new release for the head commit on master with tag and title in format vX.Y.Z
2) Run `make image` and then `make push` to push the image to the Docker Hub repo
