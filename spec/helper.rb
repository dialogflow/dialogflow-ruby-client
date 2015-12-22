require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  minimum_coverage(99.57)
end


require 'api-ai-ruby'
require 'rspec'
#require 'webmock/rspec'

#WebMock.disable_net_connect!(allow: 'coveralls.io')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end


def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
