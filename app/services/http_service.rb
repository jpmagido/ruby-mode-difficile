# frozen_string_literal: true

require 'net/http'
require 'uri'

class HttpService
  attr_reader :url, :params, :headers

  def initialize(url, params = {}, headers = {})
    @url = url
    @params = params
    @headers = headers

    raise ArgumentError, 'must provide a url:string' unless url.is_a? String
  end

  def get
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new uri
      headers.each { |key, value| request[key] = value }
      http.request request
    end

    raise RequestError, response unless response.is_a?(Net::HTTPSuccess)

    response # TODO: parse ?
  end

  def post
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(params)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    raise RequestError, response.value unless response.is_a?(Net::HTTPSuccess) || response.is_a?(Net::HTTPRedirection)

    response # TODO: parse ?
  end

  def build_url
    uri.query = params.to_query
    uri.to_s
  end

  private

  def uri
    @uri ||= URI url
  end

  class RequestError < StandardError; end
end

