module ApiAiRuby
  class ContextsRequest < ApiAiRuby::RequestQuery

    def initialize(client,  options = {})
      super client, options
      @headers['Content-Type'] = 'application/json; charset=UTF-8'
      @crud_base_uri = client.api_base_url + 'contexts'
      @uri = @crud_base_uri
    end

    # @param name [String]
    # @return [ApiAiRuby::Context]
    def retrieve(name)
      raise ApiAiRuby::ClientError.new('context name required') if !name
      @request_method = :get
      @options = nil
      @uri = @crud_base_uri + '/' + name + '?sessionId=' + self.client.api_session_id
      self.perform
    end

    # @return [Array<ApiAiRuby::Context>]
    def list
      @request_method = :get
      @uri = @crud_base_uri + '?sessionId=' + self.client.api_session_id
      @options = nil
      self.perform
    end

    # @param context [Array<ApiAiRuby::Context>, ApiAiRuby::Context, String]
    def create(contexts)

      @request_method = :post
      @uri = @crud_base_uri + '?sessionId=' + self.client.api_session_id

      @options = nil
      @options = contexts if contexts.is_a? Array
      @options = [contexts] if contexts.is_a? ApiAiRuby::Context
      @options = [{:name => contexts}] if contexts.is_a? String
      raise ApiAiRuby::ClientError.new(
          'You should pass instance of ApiAiRuby::Context, Array<ApiAiRuby::Context> or String to ContextsRequest::create ') if @options == nil
      self.perform
    end

    def delete(name = nil)
      @request_method = :delete
      @options = nil
      @uri = @crud_base_uri + '?sessionId=' + self.client.api_session_id
      @uri = @crud_base_uri + '/' + name + '?sessionId=' + self.client.api_session_id if name != nil
      # @options[:sessionId] = self.client.api_session_id
      self.perform
    end

  end
end