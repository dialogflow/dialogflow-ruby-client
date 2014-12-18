require 'net/http'
require 'uri'
require 'json'

class ApiAi
  class Client
    def initialize(obj)
      @config = obj
      uri = URI.parse(BASE_URL)
      @https = Net::HTTP.new(uri.host, uri.port)
      @https.use_ssl = true
      #@https.set_debug_output $stderr
      @req = Net::HTTP::Post.new(uri.request_uri)
      @req["Authorization"] = "Bearer #{obj.access_token}"        
      @req["ocp-apim-subscription-key"] = obj.subscription_key    
      @req["Content-Type"] = "application/json"
      @req
    end
  
    def query(str)
      data  = { q: str, lang:  @config.lang}.to_json
      data.merge({timezone: @config.timezone }) if @config.timezone
      @req.body = data.to_json
      puts @req.body
      res = @https.request @req
      JSON.parse(res.body, {:symbolize_names => true})
    end
  end
end


