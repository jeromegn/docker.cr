require "../src/docker"

Docker.client.info.containers
containers = Docker.client.containers

p containers.first