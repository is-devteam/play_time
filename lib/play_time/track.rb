module PlayTime
  class Track
    class InvalidTrack < StandardError; end

    ALPHA = 'alpha'.freeze
    BETA = 'beta'.freeze
    ROLLOUT = 'rollout'.freeze
    PRODUCTION = 'production'.freeze

    def self.validate!(track)
      raise InvalidTrack.new("#{track} is an invalid track") unless valid?(track)
    end

    private

    def self.valid?(track)
      [ALPHA, BETA, ROLLOUT, PRODUCTION].include?(track)
    end
  end
end
