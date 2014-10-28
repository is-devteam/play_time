require 'rake'
require 'play_time'

namespace :play_time do
  namespace :upload do
    PlayTime::Track::TRACKS.each do |track|
      desc "Uploads apk to #{track}"
      task(track) do |task|
        PlayTime.upload(track)
      end
    end
  end

  desc 'Creates a config file in config/play_time.yml'
  task :install do
    PlayTime.install
  end
end
