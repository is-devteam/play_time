require 'yaml'
require 'play_time/version'
require 'play_time/configuration'

module PlayTime
  def self.config_path
    ENV['PLAY_TIME_CONFIG_PATH'] || Configration::DEFAULT_CONFIG
  end

  def self.configuration
    @configuration ||= Configuration.new(YAML.load(open(config_path).read))
  end
end
