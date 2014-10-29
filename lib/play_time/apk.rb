require 'google/api_client'

module PlayTime
  class Apk
    class FileNotFound < StandardError; end

    MIME_TYPE = 'application/vnd.android.package-archive'.freeze

    class << self
      def load
        Google::APIClient::UploadIO.new(most_recent_modified_file_path, MIME_TYPE)
      end

      private

      def file_path
        PlayTime.configuration.apk_path
      end

      def most_recent_modified_file_path
        @most_recent_modified_file_path ||=
          begin
            file = Dir[file_path].map{|file_path| File.open(file_path) }.sort_by(&:mtime).last

            if file
              file.path
            else
              raise FileNotFound, "No such file or directory: #{file_path}"
            end
          end
      end
    end
  end
end
