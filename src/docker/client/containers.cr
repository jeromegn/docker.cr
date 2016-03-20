module Docker
  class Client
    module Containers

      def containers(all = false,
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

    end
  end
end