require 'helper'

describe 'api' do
  let (:client) { ApiAiRuby::Client.new(:client_access_token => '3485a96fb27744db83e78b8c4bc9e7b7')}

  it 'should return response' do
    response = client.text_request 'Hello'
    expect(response[:result][:resolvedQuery]).to eq 'Hello'
    expect(response[:result][:action]).to eq 'greeting'
  end

  it 'should use input contexts' do
    response = client.text_request 'Hello', :resetContexts => true
    expect(response[:result][:action]).to eq 'greeting'

    response = client.text_request 'Hello', :contexts => ['firstContext'], :resetContexts => true
    expect(response[:result][:action]).to eq 'firstGreeting'

    response = client.text_request 'Hello', :contexts => ['secondContext'], :resetContexts => true
    expect(response[:result][:action]).to eq 'secondGreeting'
  end

  it 'should return output contexts' do
    response = client.text_request 'weather', :resetContexts => true
    expect(response[:result][:action]).to eq 'showWeather'
    expect(response[:result][:contexts]).not_to be_nil
    expect(response[:result][:contexts].any? {|context| context[:name] == 'weather'}).to be true
  end

  it 'should response with error on wrong credentials' do
    client = ApiAiRuby::Client.new(client_access_token: 'CS')
    expect {client.text_request}.to raise_error(ApiAiRuby::RequestError)
  end

  it 'should send voiceData to API' do
    expect(client.voice_request(File.new(fixture_path + '/hello.wav'))[:result][:resolvedQuery]).to eq 'hello'
  end

  it 'should correctly set contexts with parameters' do
    client.text_request 'Hello', :resetContexts => true
    response = client.text_request 'hello', contexts: [{ name: 'user', parameters: { first_name: 'Johnny' }}]
    expect(response[:result][:contexts]).not_to be_nil
    expect(response[:result][:contexts][0][:name]).to eq 'user'
    expect(response[:result][:contexts][0][:parameters][:first_name]).to eq 'Johnny'
  end

  it 'should use custom entities' do
    response = client.text_request 'hi nori', entities: [
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
=begin
  it 'should use custom entities through separate request' do
    entry = ApiAiRuby::Entry.new 'giur', %w(Giur Amaldur)
    client.user_entities_request('dwarfs', [entry])

    response = client.text_request 'hi Amaldur'
    expect(response[:result][:action]).to eq 'say_hi'
    expect(response[:result][:fulfillment][:speech]). to eq 'hi Bilbo, I am giur'

  end

  it 'should use custom entities through separate request' do

    entity1 = ApiAiRuby::Entity.new 'dwarfs', [
        ApiAiRuby::Entry.new('test1', %w(test1 test_1)),
        ApiAiRuby::Entry.new('test2', %w(test2 test_2))
    ]

    entity2 = ApiAiRuby::Entity.new 'dwarfs', [
        ApiAiRuby::Entry.new('test1', %w(test1 test_1)),
        ApiAiRuby::Entry.new('test2', %w(test2 test_2))
    ]

    uer = client.user_entities_request
    #response = uer.create([entity1, entity2])
    response = uer.create(entity1)
    response = uer.retrieve('dwarfs')
    puts(response)

=end
end
