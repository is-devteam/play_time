require 'play_time/client'

module PlayTime
  class Promote
    class << self
      def promote(version_code, track)
        new(Client.new).promote(version_code, track)
      end
    end

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def promote(version_code, track)
      client.authorize!
      client.update(track, version_code)
    end
  end
end
