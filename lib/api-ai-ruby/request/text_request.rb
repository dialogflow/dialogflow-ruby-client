module ApiAiRuby
  class TextRequest < ApiAiRuby::RequestQuery
    def initialize (client, options={})
      options[:lang] = client.api_lang
      super client, options
    end
  end
end
