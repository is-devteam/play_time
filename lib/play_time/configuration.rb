module PlayTime
  class Configuration
    DEFAULT_CONFIG = 'config/play_time.yml'.freeze
    OPTIONS = %w(
      apk_path
      client_name
      client_version
      secret_path
      secret_passphrase
      issuer
      package_name
    ).freeze

    def initialize(config)
      @config = config
    end

    OPTIONS.each do |config_name|
      eval <<-RUBY
        def #{config_name}         # def config_option
          config["#{config_name}"] #  config['config_option']
        end                        # end
      RUBY
    end

    private

    attr_reader :config
  end
end
