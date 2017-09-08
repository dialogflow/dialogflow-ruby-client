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

require 'api-ai-ruby/constants'
require 'api-ai-ruby/client'
require 'api-ai-ruby/request_error'
require 'api-ai-ruby/client_error'
require 'api-ai-ruby/request/request_query'
require 'api-ai-ruby/request/text_request'
require 'api-ai-ruby/request/event_request'
require 'api-ai-ruby/request/voice_request'
require 'api-ai-ruby/models/context'
require 'api-ai-ruby/models/entry'
require 'api-ai-ruby/models/entity'
require 'api-ai-ruby/crud/contexts_request'
require 'api-ai-ruby/crud/user_entity_request'

module ApiAiRuby
end