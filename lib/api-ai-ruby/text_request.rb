module ApiAiRuby
  class TextRequest < ApiAiRuby::RequestQuery
    def initialize (client, options={})
      super client, options
      @request_method = :get
    end
  end
end
