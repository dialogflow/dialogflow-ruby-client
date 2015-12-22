require 'json'

module ApiAiRuby
  class VoiceRequest < ApiAiRuby::RequestQuery


    # @param client [ApiAiRuby::Client]
    # @param options [Hash]
    # @return [ApiAiRuby::VoiceRequest]
    def initialize(client,  options = {})
      super client, options

      file = options.delete(:file)
      options = {
          :request => options.to_json,
          :voiceData => HTTP::FormData::File.new(file, filename: File.basename(file))
      }
      @options = options
      self
    end

  end
end