require 'spec_helper'
require 'yaml'

describe ApiAiRuby do
  before(:all) do
    settings = YAML.load_file('.apikey.yml')
    @apiai = ApiAiRuby.new do |config|
      config.access_token = settings["access_token"]
      config.subscription_key = settings["subscription_key"]
      config.lang = settings["lang"]
    end
  end


end
