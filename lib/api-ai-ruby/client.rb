require 'securerandom'

module ApiAiRuby
  class Client
    attr_accessor :client_access_token, :subscription_key
    attr_writer :user_agent, :api_version, :api_lang, :api_base_url, :api_session_id

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [ApiAiRuby::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      if !(options.key?  :api_session_id)
        @api_session_id = SecureRandom.uuid
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

    def api_session_id
      @api_session_id
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

    # @param entity_name [String]
    # @param entries [ApiAiRuby:Entry[]]
    # @param options [Hash]
    def user_entities_request(entity_name, entries, options = {})
      raise ApiAiRuby::ClientError.new('Entity name required') if entity_name.nil?
      raise ApiAiRuby::ClientError.new('Entity entries array required') if !entries.nil? && entries.is_a?(Array)
      # raise ApiAiRuby::ClientError.new('Entity name required') if !(options.has_key?(:entries) && options[:entries].is_a?(Array))
      options[:name] = entity_name
      options[:entries] = entries
      options[:extend] = options[:extend] || false
      ApiAiRuby::UserEntitiesRequest.new(self, options).perform
    end

  end
end