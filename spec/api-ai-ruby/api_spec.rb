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
end
