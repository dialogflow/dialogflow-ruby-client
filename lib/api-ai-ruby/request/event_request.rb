module ApiAiRuby
  class EventRequest < ApiAiRuby::RequestQuery

    # @param client [ApiAiRuby::Client]
    # @param options [Hash]
    # @return [ApiAiRuby::EventRequest]
    def initialize (client, options={})
      options[:lang] = client.api_lang
      super client, options
      @headers['Content-Type'] = 'application/json; charset=UTF-8'
    end
  end
end
