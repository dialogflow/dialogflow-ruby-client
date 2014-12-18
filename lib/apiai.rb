# coding: utf-8
require "apiai/client"

class ApiAi
  attr_accessor :access_token, :subscription_key,
    :lang, :timezone
  BASE_URL = 'https://api.api.ai/v1/query/'

  def initialize(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    yield(self) if block_given?
    @client = Client.new(self)
  end

  def query(str)
    @client.query str
  end
end

apiai = ApiAi.new do |config|
  config.access_token = "d61f785bb39f42a2b1f6830e17ad3dcf"
  config.subscription_key = "6b5639dd-ffb8-4e21-8519-a2594dafc70e"
  config.lang = "en"
end
res = apiai.query("play beatles")
puts res

require "apiai/version"
