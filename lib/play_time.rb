require 'yaml'
require 'play_time/version'
require 'play_time/configuration'

module PlayTime
  DEFAULT_CONFIG = 'config/play_time.yml'.freeze

  def self.config_path
    ENV['PLAY_TIME_CONFIG_PATH'] || DEFAULT_CONFIG
  end

  def self.configuration
    @configuration ||= Configuration.new(YAML.load(open(config_path).read))
  end
end
