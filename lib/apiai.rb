# coding: utf-8
require 'net/http'
require 'uri'
require 'json'

class ApiAi
  attr_accessor :access_token, :subscription_key,
    :lang, :timezone
  BASE_URL = 'https://api.api.ai/v1/query/'

  def initialize(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    yield(self) if block_given?
    init_http_client
  end

  def query(str, opts = {})
    data = { q: str}
    data.merge!(opts) if opts
    @req.body = data.to_json
    res = @https.request @req
    JSON.parse(res.body, {:symbolize_names => true})
  end

  def req
    @req
  end

  private
  def init_http_client
    uri = URI.parse(BASE_URL)
    @https = Net::HTTP.new(uri.host, uri.port)
    @https.use_ssl = true
    @req = Net::HTTP::Post.new(uri.request_uri)
    @req["Authorization"] = "Bearer #{self.access_token}"
    @req["ocp-apim-subscription-key"] = self.subscription_key
    @req["Content-Type"] = "application/json"
    @req
  end  
end


require "apiai/version"
