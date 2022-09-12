RABBITMQ_QUEUE_MGMT_VERSION:=$(shell yq e '.rabbitmq_queue_management' versions.yaml)
RABBITMQ_QUEUE_MGMT_SHA:=$(shell yq e '.rabbitmq_queue_management_sha' versions.yaml)

IMAGE_VERSION:=$(shell yq e '.image.version' versions.yaml)
IMAGE_NAME:=$(shell yq e '.image.name' versions.yaml)

image:
	docker build \
		--build-arg RABBITMQ_QUEUE_MGMT_VERSION=${RABBITMQ_QUEUE_MGMT_VERSION} \
		--build-arg RABBITMQ_QUEUE_MGMT_SHA=${RABBITMQ_QUEUE_MGMT_SHA} \
		-t ${IMAGE_NAME}:${IMAGE_VERSION} .

push:
	docker push ${IMAGE_NAME}:${IMAGE_VERSION}
