require 'helper'

describe 'api' do
  before(:all) { @client = ApiAiRuby::Client.new(
      :client_access_token => '3485a96fb27744db83e78b8c4bc9e7b7',
      :api_session_id => 'testsession'
  )}

  it 'should return response' do
    response = @client.text_request 'Hello'
    expect(response[:result][:resolvedQuery]).to eq 'Hello'
    expect(response[:result][:action]).to eq 'greeting'
  end

  it 'should correct work with utf-8 entities' do
    response = @client.text_request '你好'
    expect(response[:result][:resolvedQuery]).to eq '你好'
  end
  it 'should use input contexts' do
    response = @client.text_request 'Hello', :resetContexts => true
    expect(response[:result][:action]).to eq 'greeting'

    response = @client.text_request 'Hello', :contexts => ['firstContext'], :resetContexts => true
    expect(response[:result][:action]).to eq 'firstGreeting'

    response = @client.text_request 'Hello', :contexts => ['secondContext'], :resetContexts => true
    expect(response[:result][:action]).to eq 'secondGreeting'
  end

  it 'should return output contexts' do
    response = @client.text_request 'weather', :resetContexts => true
    expect(response[:result][:action]).to eq 'showWeather'
    expect(response[:result][:contexts]).not_to be_nil
    expect(response[:result][:contexts].any? {|context| context[:name] == 'weather'}).to be true
  end

  it 'should response with error on wrong credentials' do
    client = ApiAiRuby::Client.new(client_access_token: 'CS')
    expect {client.text_request}.to raise_error(ApiAiRuby::RequestError)
  end

  it 'should send voiceData to API' do
    # expect(@client.voice_request(File.new(fixture_path + '/hello.wav'))[:result][:resolvedQuery]).to eq 'hello'
    # asr was disabled for non-premium users
    expect {@client.voice_request(File.new(fixture_path + '/hello.wav'))}.to raise_error(ApiAiRuby::RequestError)
  end

  it 'should correctly set contexts with parameters' do
    @client.text_request 'Hello', :resetContexts => true
    response = @client.text_request 'hello', contexts: [{ name: 'user', parameters: { first_name: 'Johnny' }}]
    expect(response[:result][:contexts]).not_to be_nil
    expect(response[:result][:contexts][0][:name]).to eq 'user'
    expect(response[:result][:contexts][0][:parameters][:first_name]).to eq 'Johnny'
  end

  it 'should use custom entities' do
    response = @client.text_request 'hi nori', entities: [
        {
            name: 'dwarfs',
            entries: [
                ApiAiRuby::Entry.new('Ori', %w(ori Nori)),
                {value: 'bifur', synonyms: %w(Bofur Bombur)}
            ]
        }
    ]

    expect(response[:result][:action]).to eq 'say_hi'
    expect(response[:result][:fulfillment][:speech]). to eq 'hi Bilbo, I am Ori'
  end

  describe 'userEntities endpoint' do

    before(:all) { @uer = @client.user_entities_request}

    let(:entity1) {
      ApiAiRuby::Entity.new 'dwarfs', [ApiAiRuby::Entry.new('giur', %w(Giur Amaldur))]
    }

    let(:entries) {
      [ApiAiRuby::Entry.new('mami', %w(Mami Nami))]
    }

    it 'should create custom entities through separate request' do
      @uer.create(entity1)
      response = @client.text_request 'hi Amaldur'
      expect(response[:result][:action]).to eq 'say_hi'
      expect(response[:result][:fulfillment][:speech]). to eq 'hi Bilbo, I am giur'
    end

    it 'should update custom entities through separate request' do
      @uer.update('dwarfs', entries)
      response = @client.text_request 'hi Nami'
      expect(response[:result][:action]).to eq 'say_hi'
      expect(response[:result][:fulfillment][:speech]). to eq 'hi Bilbo, I am mami'
    end

    it 'should retrieve custom enitities' do
      response = @uer.retrieve('dwarfs')
      expect(response[:name]).to eq 'dwarfs'
      expect(response[:entries][0][:value]).to eq 'mami'
    end

    it 'should remove custom entities' do
      @uer.delete('dwarfs')
      expect{@uer.retrieve('dwarfs')}.to raise_error(ApiAiRuby::RequestError)
    end
  end
end
