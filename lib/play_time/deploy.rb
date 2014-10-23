require 'play_time/uploader'

module PlayTime
  class Deploy
    def deploy(track)
      Uploader.new.upload(apk_path(track))
    end

    private

    def apk_path(track)
      PlayTime.configuration.apk_path(track: track)
    end
  end
end
