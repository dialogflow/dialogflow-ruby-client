require 'helper'

describe ApiAiRuby::Client do
  describe '#user_agent' do
    it 'defaults ApiAiRubyRubyGem/version' do
      expect(subject.user_agent).to eq("ApiAiRubyGem/#{ApiAiRuby::Constants::VERSION}")
    end
  end

  describe '#user_agent=' do
    it 'overwrites the User-Agent string' do
      subject.user_agent = 'MyApiAiRubyClient/1.0.0'
      expect(subject.user_agent).to eq('MyApiAiRubyClient/1.0.0')
    end
  end

  describe '#credentials?' do
    it 'returns true if all credentials are present' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK', client_access_token: 'CS')
      expect(client.credentials?).to be true
    end
    it 'returns false if any credentials are missing' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK')
      expect(client.credentials?).to be false
    end

    it 'raises error on request without credentials' do
      expect {subject.text_request '123'}.to raise_error(ApiAiRuby::ClientError)
      expect {subject.voice_request '123'}.to raise_error(ApiAiRuby::ClientError)
    end

  end

  describe '#properties' do

    it 'has correct default properties' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK', client_access_token: 'CS')
      expect(client.api_base_url).to eq ApiAiRuby::Constants::DEFAULT_BASE_URL
      expect(client.api_version).to eq ApiAiRuby::Constants::DEFAULT_API_VERSION
      expect(client.api_lang).to eq ApiAiRuby::Constants::DEFAULT_CLIENT_LANG
    end

    it 'correctly creates client with given properties' do
      client = ApiAiRuby::Client.new(subscription_key: 'SK', client_access_token: 'CS', api_lang: 'RU', api_base_url: 'http://localhost', api_version: '1234')
      expect(client.api_base_url).to eq 'http://localhost'
      expect(client.api_version).to eq '1234'
      expect(client.api_lang).to eq 'RU'
    end


  end

end
