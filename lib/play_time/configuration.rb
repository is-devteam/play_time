module PlayTime
  class Configuration
    class MissingOption < StandardError; end

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

    def self.exists?
      File.exist? PlayTime.config_path
    end

    def self.create_config(config_dir, config_path)
      unless File.exist?(config_dir)
        FileUtils.mkdir_p(config_dir)
      end

      FileUtils.cp("#{__dir__}/templates/play_time.yml", config_path)
    end

    def initialize(config)
      @config = config
    end

    OPTIONS.each do |config_name|
      eval <<-RUBY
        def #{config_name}
          config["#{config_name}"] || raise(MissingOption, "Missing #{config_name} in \#{PlayTime.config_path}")
        end
      RUBY
    end

    private

    attr_reader :config
  end
end
