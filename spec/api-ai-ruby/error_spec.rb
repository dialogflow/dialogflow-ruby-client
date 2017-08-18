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

require 'helper'

describe ApiAiRuby::RequestError do
  describe '#code' do
    it 'returns the error code' do
      error = ApiAiRuby::RequestError.new('execution expired', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#message' do
    it 'returns the error message' do
      error = ApiAiRuby::RequestError.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end
end

describe ApiAiRuby::ClientError do

end