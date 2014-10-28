require 'google/api_client'

module PlayTime
  class Apk
    MIME_TYPE = 'application/vnd.android.package-archive'.freeze

    class << self
      def load
        Google::APIClient::UploadIO.new(path, MIME_TYPE)
      end

      private

      def path
        PlayTime.configuration.apk_path
      end
    end
  end
end
