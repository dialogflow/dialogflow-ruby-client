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

require 'json'

module ApiAiRuby
  class VoiceRequest < ApiAiRuby::RequestQuery


    # @param client [ApiAiRuby::Client]
    # @param options [Hash]
    # @return [ApiAiRuby::VoiceRequest]
    def initialize(client,  options = {})
      options[:lang] = client.api_lang
      super client, options
      file = options.delete(:file)
      options = {
          :request => options.to_json,
          :voiceData => HTTP::FormData::File.new(file, filename: File.basename(file))
      }
      @options = options
      self
    end

  end
end