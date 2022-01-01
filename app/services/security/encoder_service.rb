# frozen_string_literal: true

require 'jwt'

module Security
  class EncoderService
    attr_reader :token

    def initialize(token:)
      @token = token

      raise ArgumentError, 'You must use a String' unless token.is_a? String
    end

    def encode
      JWT.encode payload, ENV['ENCODING_PASSWORD'], 'HS256'
    end

    def decode
      jwt_decode_response.first['data']
    end

    private

    def payload
      { data: token }
    end

    def jwt_decode_response
      JWT.decode(token, ENV['ENCODING_PASSWORD'], true, { algorithm: 'HS256' })
    end
  end
end
