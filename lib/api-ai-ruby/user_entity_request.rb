module ApiAiRuby
  class UserEntitiesRequest < ApiAiRuby::RequestQuery

    def initialize(client,  options = {})
      super client, options
      @uri = client.api_base_url + 'userEntities'
    end

  end
end