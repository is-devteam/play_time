module PlayTime
  class Configuration
    attr_reader :app_id
    DEFAULT_CONFIG = 'config/play_time.yml'.freeze

    def initialize(config)
      @app_id = config['app_id'] || config[:app_id]
    end
  end
end
