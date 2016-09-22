module ApiAiRuby
  class TextRequest < ApiAiRuby::RequestQuery
    def initialize (client, options={})
      options[:lang] = client.api_lang
      super client, options
      @headers['Content-Type'] = 'application/json; charset=UTF-8'
    end
  end
end
