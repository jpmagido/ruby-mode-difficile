# frozen_string_literal: true

require 'net/http'
require 'uri'

# TODO: rspec
class GithubApi
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def find_user
    uri = URI 'https://api.github.com/user'

    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "token #{token}"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    raise RequestError, 'get user request failed' unless res.is_a?(Net::HTTPSuccess)

    res.body
  end

  class RequestError < StandardError; end
end

