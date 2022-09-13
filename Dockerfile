FROM eclipse-temurin:17.0.4.1_1-jdk-focal as builder

ARG RABBITMQ_QUEUE_MGMT_SHA
RUN apt-get update -y -q \
    && apt-get install -y --no-install-recommends -q git \
    && git clone https://github.com/gessnerfl/rabbitmq-queue-management.git src \
    && cd src \
    && git checkout -q ${RABBITMQ_QUEUE_MGMT_SHA} \
    && sed -i -e 's/\r$//' gradlew \
    && ./gradlew bootJar

FROM eclipse-temurin:17.0.4.1_1-jre-focal

RUN useradd -m -u 10000 -U spring 
USER spring
WORKDIR /home/spring

ARG RABBITMQ_QUEUE_MGMT_VERSION
COPY --from=builder /src/build/libs/rabbitmq-queue-management-${RABBITMQ_QUEUE_MGMT_VERSION}.jar rabbitmq-queue-management.jar
COPY --chown=spring:spring artifacts/docker-entrypoint.sh docker-entrypoint.sh

EXPOSE 8780
EXPOSE 8781
ENTRYPOINT [ "/home/spring/docker-entrypoint.sh" ]