require 'play_time/client'

module PlayTime
  class Upload
    def self.upload(track)
      new(Client.new).upload(track)
    end

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def upload(track)
      client.authorize!

      client.commit(track)
    end
  end
end
