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

  namespace :promote do
    PlayTime::Track::TRACKS.each do |track|
      desc "Promote apk version code to #{track}"
      task(track, :version_code) do |task, args|
        PlayTime.promote(track, args[:version_code].to_i)
      end
    end
  end

  desc 'Creates a config file in config/play_time.yml'
  task :install do
    PlayTime.install
  end
end
