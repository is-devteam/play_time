require 'bundler/gem_tasks'

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: 'spec:default'

namespace :spec do
  %w(
    default
  ).each do |config_file|
    desc "Run Tests against config: #{config_file}.yml"
    task config_file do
      sh "PLAY_TIME_CONFIG_PATH=spec/support/config/#{config_file}.yml bundle exec rake spec"
    end
  end
end
