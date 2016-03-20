require "../src/docker"

# client = Docker::Client.new

p Docker.info.containers
containers = Docker::Container.all
containers.first.exec "ls -lah", tty: false
# containers.first.exec "bash", tty: true