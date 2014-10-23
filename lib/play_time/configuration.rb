module PlayTime
  class Configuration
    attr_reader :app_id

    def initialize(config)
      @app_id = config['app_id'] || config[:app_id]
    end
  end
end
