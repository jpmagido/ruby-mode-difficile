# frozen_string_literal: true

require 'net/http'
require 'uri'

# TODO: rspec
class HttpService
  attr_reader :url, :params, :headers

  def initialize(url, params = {}, headers = {})
    @url = url
    @params = params
    @headers = headers
  end

  def get
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new uri
      headers.each { |key, value| request[key] = value }
      http.request request
    end

    raise RequestError, response unless response.is_a?(Net::HTTPSuccess)

    response
  end

  def post
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(params)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    raise RequestError, response.value unless response.is_a?(Net::HTTPSuccess) || response.is_a?(Net::HTTPRedirection)

    response
  end

  private

  def uri
    @uri ||= URI url
  end

  class RequestError < StandardError; end
end

