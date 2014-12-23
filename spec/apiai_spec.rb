require 'spec_helper'
require 'yaml'
require 'json'

describe ApiAi do
  before(:all) do
    @settings = YAML.load_file('.apikey.yml')
    @apiai = ApiAi.new do |config|
      config.access_token = @settings["access_token"]
      config.subscription_key = @settings["subscription_key"]
    end
  end

  describe "initialize" do
    it 'get instance' do
      expect(@apiai).not_to be_nil
    end

    it 'has access keys' do
      expect(@apiai.access_token).not_to be_nil
    end
  end

  describe "client instance" do
    it 'can access api.ai' do
      res = @apiai.query("AAA")
      expect(res[:status][:code]).to eq 200
    end

    it 'has option parameter' do
      opts = { lang: "en", timezone: "Asia/Tokyo"}
      @apiai.query("AAA", opts)
      expect(JSON.parse(@apiai.req.body)).to include("lang" => "en")
    end
  end
end
