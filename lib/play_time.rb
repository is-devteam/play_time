require 'yaml'
require 'play_time/version'
require 'play_time/track'
require 'play_time/configuration'
require 'play_time/upload'
require 'play_time/promote'

module PlayTime
  class << self
    def config_path
      ENV['PLAY_TIME_CONFIG_PATH'] || Configuration::DEFAULT_CONFIG
    end

    def configuration
      @configuration ||= Configuration.new(YAML.load(open(config_path).read))
    end

    def upload(track)
      Upload.upload(track)
    end

    def promote(version_code, track)
      Promote.promote(version_code, track)
    end

    def install
      if Configuration.exists?
        puts "You already have a config file in #{config_path}!"
      else
        puts "Generating a new config file: #{config_path}"
        Configuration.create_config('config', config_path)
      end
    end
  end
end
