require 'helper'

describe ApiAiRuby::Client do

  let (:client) { ApiAiRuby::Client.new(:client_access_token => 'CS')}

  it 'should throw error on user_entities_request without name' do
    expect {client.user_entities_request nil, nil}.to raise_error(ApiAiRuby::ClientError)
  end

  it 'should throw error on user_entities_request without entries' do
    expect {client.user_entities_request 'name', nil}.to raise_error(ApiAiRuby::ClientError)
    expect {client.user_entities_request 'name', []}.to raise_error(ApiAiRuby::ClientError)
  end
=begin
  it 'unfinished' do
    entry = ApiAiRuby::Entry.new 'test', %w(test entry)
    entry1 = ApiAiRuby::Entry.new 'test1', %w(second test entry)
    options = {
        :name => 'test',
        :extend => false,
        :entries => [entry, entry1]
    }
    request = ApiAiRuby::UserEntitiesRequest.new(client, options)
    expect(request).to  true
  end
=end
end
