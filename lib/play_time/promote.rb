require 'play_time/client'

module PlayTime
  class Promote
    class << self
      def promote(track, version_code)
        new(Client.new).promote(track, version_code)
      end
    end

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def promote(track, version_code)
      client.authorize!
      client.update(track, version_code)
    end
  end
end
