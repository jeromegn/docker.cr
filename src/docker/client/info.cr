module Docker
  class Client
    module Info

      def info
        Docker::Info.from_json(get("/info").body)
      end

    end
  end
end