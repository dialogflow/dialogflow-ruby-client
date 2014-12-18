require 'spec_helper'
require 'yaml'

describe ApiAi do
  before(:all) do
    settings = YAML.load_file('.apikey.yml')
    @apiai = ApiAi.new do |config|
      config.access_token = settings["access_token"]
      config.subscription_key = settings["subscription_key"]
      config.lang = settings["lang"]
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

  describe "call api" do
    it 'access api.ai' do
      res = @apiai.query("play beatles")
      puts res
      expect(res).not_to be_nil
    end
  end

end
