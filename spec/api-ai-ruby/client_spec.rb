# Copyright 2017 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
      expect(client.api_session_id).to be_a(String)
    end

    it 'correctly creates client with given properties' do
      client = ApiAiRuby::Client.new(
          subscription_key: 'SK',
          client_access_token: 'CS',
          api_lang: 'RU',
          api_base_url: 'http://localhost',
          api_version: '1234',
          api_session_id: '555',
          timeout_options: [:global, { write: 1, connect: 1, read: 1}]
      )

      expect(client.api_base_url).to eq 'http://localhost'
      expect(client.api_version).to eq '1234'
      expect(client.api_lang).to eq 'RU'
      expect(client.api_session_id).to eq '555'
      expect(client.timeout_options).to eq [:global, { write: 1, connect: 1, read: 1}]
    end


  end

end
