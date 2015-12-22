require 'helper'

describe ApiAiRuby::RequestError do
  describe '#code' do
    it 'returns the error code' do
      error = ApiAiRuby::RequestError.new('execution expired', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#message' do
    it 'returns the error message' do
      error = ApiAiRuby::RequestError.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end
end

describe ApiAiRuby::ClientError do

end