# Crystal Docker API client

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  docker:
    github: jeromegn/docker.cr
```

## Status: Developer Preview

This is not nearly complete. Just got the initial connecting working and simple casting. I added a few commands as a proof of concept.

This shard extends OpenSSL and HTTP::Client a little bit to support Docker's SSL method (TLS V1.)

## Usage

```crystal
require "docker"
```

### Options

By default, options will be taken from the environment variables:

```
DOCKER_URL or DOCKER_HOST
DOCKER_VERIFY_TLS
DOCKER_CERT_PATH
```

but they can also be set manually like:

```crystal
Docker.client.url = "tcp://192.168.99.100:2376"
Docker.client.verify_tls = true
Docker.client.cert_path = "#{ENV["HOME"]}/.docker"
```

If nothing is set, this client will use the unix socket.

### Info

```crystal
Docker.client.info.container # => Returns container count
```

### Containers

```crystal
Docker.client.containers # => Array of Docker::Container
container = Docker.client.containers.first
p container # => #<Docker::Container:0x10f6a3ea0 @id="cbbeb51f25b4c91b61e6d1b5fc0c1c2bb470ccd8aaf5dc4a57885f35f21d7245", @names=["api"], @image="ruby" ...>

container.stop
container.start
container.restart
container.kill
```

## Contributing

1. Fork it ( https://github.com/jeromegn/docker.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jeromegn](https://github.com/jeromegn) Jerome Gravel-Niquet - creator, maintainer
