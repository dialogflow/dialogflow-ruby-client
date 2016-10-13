require 'helper'

describe ApiAiRuby::TextRequest do
  let(:client) do
    ApiAiRuby::Client.new(
      client_access_token: 'CS',
      api_lang: 'EN',
      api_session_id: '555',
      timeout_options: [:global, { write: 1, connect: 1, read: 1 }]
    )
  end

  subject(:text_request) { described_class.new(client, options) }
  let(:options) { { query: "hello" } }

  around do |test|
    begin
      WebMock.disable_net_connect!(allow: 'coveralls.io')
      test.run
    ensure
      WebMock.allow_net_connect!
    end
  end

  let(:response_headers) do
    { "Content-Type" => "application/json;charset=UTF-8", "Content-Length" => "437", "Connection" => "close", "Access-Control-Allow-Credentials" => "true", "Cache-Control" => "no-cache=\"set-cookie\"", "Date" => "Wed, 12 Oct 2016 20:07:54 GMT", "Server" => "nginx/1.9.7", "Set-Cookie" => "AWSELB=9D5B4D210CCFFAF1BE1E0CD7C7E6FCBD7B46140CAAF64A202A005B9079598B549F7A5EC269DD0FF88508DA57410EFC7882B7860453691E7ACC870186C9D1589D2A332B51EC;PATH=/", "X-Cache" => "Miss from cloudfront", "Via" => "1.1 978198446b6fdba8a499c04f84a3a7e6.cloudfront.net (CloudFront)", "X-Amz-Cf-Id" => "ilwhpG75Ea4iXumklw7484nYt2jbx-L6ZaeiO9naUOstx45ia_nuaQ==" }
  end
  let(:body) do
    { :id => "94613973-930f-4a53-9286-6e9efcbb5c57", :timestamp => "2016-10-12T20:07:54.876Z", :result => { :source => "domains", :resolvedQuery => "hello", :action => "smalltalk.greetings", :parameters => { :simplified => "hello" }, :metadata => {}, :fulfillment => { :speech => "Good day!" }, :score => 0.0 }, :status => { :code => 200, :errorType => "success" }, :sessionId => "555" }
  end
  let(:expected_headers) do
    { 'Authorization' => 'Bearer CS', 'Connection' => 'close', 'Content-Type' => 'application/json; charset=UTF-8', 'Host' => 'api.api.ai' }
  end
  let(:expected_url) { "https://api.api.ai/v1/query?v=20150910" }
  let(:expected_body) { '{"query":"hello","lang":"EN","sessionId":"555"}' }

  describe "#perform" do
    it "performs a request" do
      stub = stub_request(:post, expected_url).
        with(:body => expected_body,
             :headers => expected_headers).
        to_return(:status => 200, :body => body.to_json, :headers => response_headers)
      subject.perform
      expect(stub).to have_been_requested
    end

    context "it times out" do
      it "times out properly" do
        stub = stub_request(:post, expected_url).
          with(:body => expected_body,
               :headers => expected_headers).to_timeout
        expect {
          subject.perform
        }.to raise_error(Errno::ETIMEDOUT)
        expect(stub).to have_been_requested
      end
    end
  end
end
