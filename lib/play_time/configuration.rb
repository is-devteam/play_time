module PlayTime
  class Configuration
    DEFAULT_CONFIG = 'config/play_time.yml'.freeze

    def initialize(config)
      @config = config
    end

    def app_id
      @app_id ||= config['app_id']
    end

    def apk_path(track:)
      PlayTime::Track.validate!(track)

      config[track]
    end

    private

    attr_reader :config

  end
end
