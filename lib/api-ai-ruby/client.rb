module ApiAiRuby
  class Client
    attr_accessor :client_access_token, :subscription_key
    attr_writer :user_agent, :api_version, :api_lang, :api_base_url

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Twitter::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    # @return [String]
    def user_agent
      @user_agent ||= "ApiAiRubyGem/#{ApiAiRuby::Constants::VERSION}"
    end

    def api_base_url
      @api_base_url ||= ApiAiRuby::Constants::DEFAULT_BASE_URL
    end

    def api_lang
      @api_lang ||= ApiAiRuby::Constants::DEFAULT_CLIENT_LANG
    end

    def api_version
      @api_version ||= ApiAiRuby::Constants::DEFAULT_API_VERSION
    end

    # @return [Hash]
    def credentials
      {
          client_access_token: client_access_token,
      }
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    def text_request (query = '', options = {})
      raise ApiAiRuby::ClientError.new('Credentials missing') if !credentials?
      options[:query] = query
      ApiAiRuby::TextRequest.new(self, options).perform
    end

    def voice_request(file_stream, options = {})
      raise ApiAiRuby::ClientError.new('Credentials missing') if !credentials?
      options[:file] = file_stream
      ApiAiRuby::VoiceRequest.new(self, options).perform
    end

  end
end