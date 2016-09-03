module ApiAiRuby
  class Entry
    attr_accessor :value, :synonyms

    # @param value [String]
    # @param synonyms [Array]
    def initialize (value, synonyms)
      @value = value
      @synonyms = synonyms
    end

    def to_json(*args)
      {
          :value => @value,
          :synonyms => @synonyms
      }.to_json(*args)
    end
  end
end