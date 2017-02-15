module ApiAiRuby
  class Context
    attr_accessor :name, :lifespan, :parameters

    # @param name [String]
    # @param lifespan [Numeric]
    # @param parameters [Hash]
    def initialize (name, lifespan = 5, parameters = {})
      @name = name
      @lifespan = lifespan
      @parameters = parameters
    end

    def to_json(*args)
      {
          :name => name,
          :lifespan => lifespan,
          :parameters => parameters
      }.to_json(*args)
    end

  end
end