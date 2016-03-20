module Docker
  class Container

    JSON.mapping({
      id: {key: "Id", type: String},
      names: {key: "Names", nilable: true, type: Array(String)},
      image: {key: "Image", nilable: true, type: String},
      image_id: {key: "ImageID", nilable: true, type: String},
      command: {key: "Command", nilable: true, type: String},
      created: {key: "Created", nilable: true, type: Int64},
      status: {key: "Status", nilable: true, type: String},
      ports: {key: "Ports", nilable: true, type: Array(Hash(String, JSON::Any))},
      labels: {key: "Labels", nilable: true, type: Hash(String, String)},
      size_rw: {key: "SizeRw", nilable: true, type: Int32},
      size_root_fs: {key: "SizeRootFs", nilable: true, type: Int32},
      network_settings: {key: "NetworkSettings", nilable: true, type: Hash(String, JSON::Any)},
    })

    def self.all(
      all = false,
      limit = nil : Int32?,
      since = nil : String?,
      before = nil : String?,
      size = false,
      filters = {} of String => Array(String)
    )
      params = HTTP::Params.build do |qs|
        qs.add "all", all.to_s
        qs.add "limit", limit.to_s
        qs.add "since", since
        qs.add "before", before
        qs.add "size", size.to_s
        qs.add "filters", filters.to_json
      end
      cs = [] of Container
      JSON.parse(Docker.client.get("/containers/json?#{params}").body).each do |c|
        cs << Container.from_json(c.to_json)
      end
      cs
    end
  
    def logs(follow = true, stdout = true, stderr = true, since = 0, timestamps = false)
      params = HTTP::Params.build do |qs|
        qs.add "follow", follow.to_s
        qs.add "stdout", stdout.to_s
        qs.add "stderr", stderr.to_s
        qs.add "since", since.to_s
        qs.add "timestamps", timestamps.to_s
      end
      Docker.client.client.get("/containers/#{id}/logs?#{params}") do |response|
        raise "unexpected status code #{response.status_code}" unless response.status_code == 200
        begin
          response.body_io.each_line do |line|
            print line # unless line.strip.empty?
          end
        rescue e
          puts e
          response.body_io.close
        end
      end
    end

  end
end