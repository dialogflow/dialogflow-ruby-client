module ApiAiRuby
  class Entity
    attr_accessor :name, :entries

    # @param name [String]
    # @param entries [Array<ApiAiRuby::Entry, Hash>]
    def initialize (name, entries)
      @name = name
      @entries = entries
    end

    def to_json(*args)
      {
          :name => name,
          :entries => entries
      }.to_json(*args)
    end

    def add_entry(value, synonyms)
      @entries.push new ApiAiRuby::Entry(value, synonyms)
    end

  end
end