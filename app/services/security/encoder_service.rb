# frozen_string_literal: true

module Security
  class EncoderService
    def initialize(token:)
      @token = token
    end

    def encode
      JWT.encode @token, ENV['ENCODING_PASSWORD'], 'none'
    end

    def decode
      JWT.decode @token, ENV['ENCODING_PASSWORD'], false
    end
  end
end
