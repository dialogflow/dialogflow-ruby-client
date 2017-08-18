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

require 'http'

module ApiAiRuby
  class RequestQuery

    attr_accessor :client, :headers, :options, :request_method, :uri

    # @param client [ApiAiRuby::Client]
    # @param options [Hash]
    # @return [ApiAiRuby::RequestQuery]

    def initialize(client, options = {})
      @client = client
      @uri = client.api_base_url + 'query?v=' + client.api_version
      @request_method = :post
      options[:sessionId] = client.api_session_id
      @options = options
      @headers = {
          Authorization: 'Bearer ' + client.client_access_token,
      }
      @timeout_options = client.timeout_options || options[:timeout_options]
    end

    # @return [Hash]
    def perform
      if @options && @options.is_a?(Hash) && @options.has_key?(:voiceData)
        options_key = :form
      else
        options_key = (@request_method === :get) ? :params : :json
      end

      request = HTTP.headers(@headers)
      request = request.timeout(*@timeout_options) if @timeout_options
      response = request.public_send(@request_method, @uri.to_s, options_key => @options) if @options
      response = request.public_send(@request_method, @uri.to_s) if @options == nil
      response_body = symbolize_keys!(response.parse)
      fail_or_return_response_body(response.code, response_body)
    end

    private

    def fail_or_return_response_body(code, body)
      error = false
      if code != 200 || (body.is_a?(Hash) && body[:status] && body[:status][:code] && body[:status][:code] != 200)
        error = ApiAiRuby::RequestError.new body[:status][:errorDetails], body[:status][:code]
      end
      fail(error) if error
      body
    end

    def symbolize_keys!(object)
      if object.is_a?(Array)
        object.each_with_index do |val, index|
          object[index] = symbolize_keys!(val)
        end
      elsif object.is_a?(Hash)
        object.keys.each do |key|
          object[key.to_sym] = symbolize_keys!(object.delete(key))
        end
      end
      object
    end

  end
end
