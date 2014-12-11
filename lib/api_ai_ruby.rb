# coding: utf-8
require "api_ai_ruby/api_qlient"

class ApiAiRuby
  attr_accessor :access_token, :subscription_key, :lang
  BASE_URL = 'https://api.api.ai/v1/query/'

  def initialize(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    yield(self) if block_given?
    @client = ApiClient.new(self)
  end

  def query(str)
    @client.query str
  end
end

require "api_ai_ruby/version"
