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

require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  minimum_coverage(95)
end


require 'api-ai-ruby'
require 'rspec'
require 'webmock'
require 'webmock/rspec'

WebMock.allow_net_connect!

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
