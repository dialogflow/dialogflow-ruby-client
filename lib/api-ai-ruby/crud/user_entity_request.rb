module ApiAiRuby
  class UserEntitiesRequest < ApiAiRuby::RequestQuery

    def initialize(client,  options = {})
      super client, options
      @uri = client.api_base_url + 'userEntities'
    end


    def create(argument)
      if !(argument && (argument.is_a?(Array) || argument.is_a?(Hash) || argument.is_a?(ApiAiRuby::Entity)))
        raise ApiAiRuby::ClientError.new('Argument should be array of Entities or single Entity object')
      end

      @request_method = :post
      @options[:entities] = argument.is_a?(Array) ? argument : [argument]
      self.perform
      @options.delete(:entities)
    end

    def retrieve(name)
      raise ApiAiRuby::ClientError.new('Entity name required') if !name
      @request_method = :get
      @uri = @uri + '/' + name
      self.perform
    end

    def update(name, entity)
      raise ApiAiRuby::ClientError.new('Entity name required') if !name
      @request_method = :update
      @uri = @uri + '/' + name
    end

    def delete(name)
      raise ApiAiRuby::ClientError.new('Entity name required') if !name
      @request_method = :delete
      @uri = @uri + '/' + name
    end

  end
end