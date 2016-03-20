require "webmock"
require "../src/docker"

ENV.delete("DOCKER_TLS_VERIFY")
ENV.delete("DOCKER_HOST")
ENV.delete("DOCKER_URL")
ENV.delete("DOCKER_CERT_PATH")

require "spec2"
include Spec2::GlobalDSL
Spec2.doc