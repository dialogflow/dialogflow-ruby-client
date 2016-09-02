module ApiAiRuby
  class TextRequest < ApiAiRuby::RequestQuery
    def initialize (client, options={})
      super client, options
    end
  end
end
