module PlayTime
  class Runner
    class ResponseError < StandardError; end

    class << self
      def run!(client, options = {})
        response = client.execute(options)

        if response.data && (error = response.data['error'])
          raise ResponseError, error
        else
          response
        end
      end
    end
  end
end
