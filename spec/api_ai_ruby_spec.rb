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


end
