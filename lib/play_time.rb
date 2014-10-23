require 'yaml'
require 'play_time/version'
require 'play_time/track'
require 'play_time/configuration'
require 'play_time/deploy'
require 'play_time/uploader'

module PlayTime
  def self.config_path
    ENV['PLAY_TIME_CONFIG_PATH'] || Configration::DEFAULT_CONFIG
  end

  def self.configuration
    @configuration ||= Configuration.new(YAML.load(open(config_path).read))
  end

  def self.deploy(track)
    deploy = Deploy.new
    deploy.deploy(track)
  end
end
