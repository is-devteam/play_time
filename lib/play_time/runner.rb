module PlayTime
  class Runner
    class IOError < StandardError; end
    class ResponseError < StandardError; end

    class << self
      def run!(client, options = {})
        response = client.execute(options)

        if error?(response)
          raise error_for(response)
        else
          response
        end
      end

      private

      def has_data?(response)
        response && response.data 
      end

      def error?(response)
        !has_data?(response) || response.data['error']
      end

      def error_message(response)
        response.data['error'] if has_data?(response)
      end

      def error_for(response)
        if error_message = error_message(response)
          ResponseError.new(error_message)
        else
          IOError
        end
      end
    end
  end
end
